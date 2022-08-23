import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_mock_model.dart';
import 'jwt_repository_test.dart';

const userKey = 'user';

class AuthRepositoryTestImpl implements AuthRepository {
  AuthRepositoryTestImpl(this._read);

  final Reader _read;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final token = _read(jwtRepositoryProvider).generateJwt(dummyUser);

    _read(sharedPreferencesProvider).setString(
      userKey,
      jsonEncode(
        dummyUser.copyWith(token: token),
      ),
    );
  }

  @override
  User? getUser() {
    final userString = _read(sharedPreferencesProvider).getString('user');

    if (userString != null) {
      final user = User.fromJson(
        jsonDecode(userString),
      );

      final userMap = _read(jwtRepositoryProvider).verifyJwt(user);

      if (userMap != null) {
        final verifiedUser = User.fromJson(userMap['server']);

        return verifiedUser;
      } else {
        final localUserMap = jsonDecode(
          _read(sharedPreferencesProvider).getString('user')!,
        );

        final localUser = User.fromJson(localUserMap..remove('token'));

        final token = _read(jwtRepositoryProvider).generateJwt(localUser);

        saveUser(localUser.copyWith(token: token));

        return getUser();
      }
    }
    return null;
  }

  @override
  Future<void> saveUser(User user) async {
    _read(sharedPreferencesProvider).setString(
      userKey,
      jsonEncode(
        dummyUser.toJson(),
      ),
    );
  }

  @override
  Future<void> removeUser() async {
    _read(sharedPreferencesProvider).remove(userKey);
  }
}

void main() async {
  SharedPreferences.setMockInitialValues(
    <String, Object>{},
  );

  var sharedPreferences = await SharedPreferences.getInstance();

  group(
    'Test Job Repository',
    () {
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          authRepositoryProvider.overrideWithProvider(
            Provider.autoDispose(
              (ref) => AuthRepositoryTestImpl(ref.read),
            ),
          ),
          jwtRepositoryProvider.overrideWithProvider(
            Provider(
              (ref) => JwtRepositoryTestImpl(),
            ),
          ),
        ],
      );

      test(
        'Sign in - signs in a user',
        () async {
          container
              .read(authRepositoryProvider)
              .signIn(email: dummyUser.email!, password: dummyUser.password!);

          final userString =
              container.read(sharedPreferencesProvider).getString(userKey);

          expect(userString, isNotNull);
        },
      );
      test(
        'Get user - returns a user object when a user has logged in',
        () async {
          container
              .read(authRepositoryProvider)
              .signIn(email: dummyUser.email!, password: dummyUser.password!);

          final user = container.read(authRepositoryProvider).getUser();

          expect(user, isInstanceOf<User>());
        },
      );
      test(
        'Get user - returns null when no login action has been performed',
        () async {
          SharedPreferences.setMockInitialValues(
            <String, Object>{},
          );

          final user = container.read(authRepositoryProvider).getUser();

          expect(user, isInstanceOf<User>());
        },
      );
      test(
        'Save user - saves a user',
        () async {
          final token =
              container.read(jwtRepositoryProvider).generateJwt(dummyUser);

          dummyUser = dummyUser.copyWith(token: token);
          container.read(authRepositoryProvider).saveUser(dummyUser);

          final user = container.read(authRepositoryProvider).getUser();

          expect(user!.email, 'email');
          expect(user.firstName, 'firstName');
          expect(user.lastName, 'lastName');
          expect(user.phone, '+44 1234567890');
        },
      );
      test(
        'Remove user - removes a user',
        () async {
          container.read(authRepositoryProvider).saveUser(dummyUser);

          container.read(authRepositoryProvider).removeUser();

          final user = container.read(authRepositoryProvider).getUser();
          expect(user, isNull);
        },
      );
    },
  );
}
