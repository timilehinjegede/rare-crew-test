import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';
import 'package:rare_crew/core/models/models.dart';

final jwtRepositoryProvider = Provider<JwtRepository>((ref) {
  return JwtRepositoryImpl();
});

abstract class JwtRepository {
  String generateJwt(User user);
  Map<String, dynamic>? verifyJwt(User user);
}

class JwtRepositoryImpl implements JwtRepository {
  @override
  String generateJwt(User user) {
    // create a json web token
    final jwt = JWT(
      {
        'id': 123,
        'server': {
          'id': '3e4fc296',
          'loc': 'euw-2',
          // user details
          ...user.toJson(),
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
