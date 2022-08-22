import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read);
});

abstract class AuthRepository {
  void signIn({required String email, required String password});

  Future<void> saveUser(User user);
  User? getUser();
  Future<void> removeUser();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._read);

  final Reader _read;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // create a user object with the email provided on sign in
    var user = User(
      email: email,
      firstName: 'John',
      lastName: 'Doe',
      phone: '+44 1234567890',
    );

    final token = _read(jwtRepositoryProvider).generateJwt(user);

    _read(sharedPreferencesProvider).setString(
      'user',
      jsonEncode(user.copyWith(token: token)),
    );
  }

  @override
  User? getUser() {
    // verify the token
    final userString = _read(sharedPreferencesProvider).getString('user');

    if (userString != null) {
      final user = User.fromJson(
        jsonDecode(userString),
      );

      final userMap = _read(jwtRepositoryProvider).verifyJwt(user.token!);

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
      'user',
      jsonEncode(user.toJson()),
    );
  }

  @override
  Future<void> removeUser() async {
    _read(sharedPreferencesProvider).remove('user');
  }
}
