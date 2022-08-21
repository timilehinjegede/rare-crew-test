import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
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
  Future<void> signIn({required String email, required String password});
  Future<User?> getUser();
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> removeToken();
  // Future<void> refreshToken();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._read);

  final Reader _read;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // Create a json web token
    final jwt = JWT(
      {
        'id': 123,
        'server': {
          'id': '3e4fc296',
          'loc': 'euw-2',
          // user details
          'email': email,
          // add dummy extra details
          'first_name': 'John',
          'last_name': 'Doe',
          'phone': '+44 1234567890',
        }
      },
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );

    // Sign it (default with HS256 algorithm)
    final token = jwt.sign(SecretKey('passphrase'));
    await saveToken(token);

    log('Signed token: $token\n');
  }

  @override
  Future<User?> getUser() async {
    try {
      // Verify a token
      final jwt = JWT.verify(getToken()!, SecretKey('passphrase'));

      log('Payload: ${jwt.payload}');

      return User.fromJson(jwt.payload['server']);
    } on JWTExpiredError {
      log('jwt expired');
    } on JWTError catch (ex) {
      log(ex.message); // ex: invalid signature
    }
    return null;
  }

  @override
  String? getToken() {
    return _read(sharedPreferencesProvider).getString('token');
  }

  @override
  Future<void> saveToken(String token) async {
    _read(sharedPreferencesProvider).setString('token', token);
  }

  @override
  Future<void> removeToken() async {
    _read(sharedPreferencesProvider).remove('token');
  }
}
