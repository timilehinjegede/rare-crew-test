import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_mock_model.dart';

class JwtRepositoryTestImpl implements JwtRepository {
  @override
  String generateJwt(User user) {
    final jwt = JWT(
      {
        'id': 123,
        'server': {
          'id': '3e4fc296',
          'loc': 'euw-2',
          // user details
          ...dummyUser.toJson(),
        }
      },
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );

    // sign it (default with HS256 algorithm)
    final token = jwt.sign(
      // use the user password as a passphrase
      SecretKey(user.password!),
      expiresIn: const Duration(seconds: 10),
    );

    return token;
  }

  @override
  Map<String, dynamic>? verifyJwt(User user) {
    try {
      final jwt = JWT.verify(
        user.token!,
        SecretKey(user.password!),
      );

      return jwt.payload;
    } on JWTError catch (_) {
      return null;
    }
  }
}

void main() async {
  SharedPreferences.setMockInitialValues(
    <String, Object>{},
  );

  var sharedPreferences = await SharedPreferences.getInstance();

  group(
    'Test Jwt Repository',
    () {
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          jwtRepositoryProvider.overrideWithProvider(
            Provider(
              (ref) => JwtRepositoryTestImpl(),
            ),
          ),
        ],
      );

      test(
        'Generate jwt - generates and returns a jwt',
        () async {
          final token =
              container.read(jwtRepositoryProvider).generateJwt(dummyUser);

          expect(token, isNotEmpty);
        },
      );
      test(
        'Verify jwt - returns a map if a jwt verification succeeds',
        () async {
          final token =
              container.read(jwtRepositoryProvider).generateJwt(dummyUser);

          dummyUser = dummyUser.copyWith(
            token: token,
          );

          final result =
              container.read(jwtRepositoryProvider).verifyJwt(dummyUser);

          expect(result, isMap);
          final verifiedUser = User.fromJson(result!['server']);

          expect(verifiedUser, isInstanceOf<User>());
        },
      );
      test(
        'Verify jwt - returns a null if a jwt verification fails',
        () async {
          final token =
              container.read(jwtRepositoryProvider).generateJwt(dummyUser);

          dummyUser = dummyUser.copyWith(
            token: token,
          );

          await Future.delayed(const Duration(seconds: 10));

          dummyUser = dummyUser.copyWith(
            token: token,
          );

          final result =
              container.read(jwtRepositoryProvider).verifyJwt(dummyUser);

          expect(result, isNull);
        },
      );
    },
  );
}
