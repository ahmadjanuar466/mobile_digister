import 'dart:convert';

class JwtDecoder {
  static String _base64UrlDecode(String input) {
    String output = input.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }

  static Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT token');
    }

    final header = _base64UrlDecode(parts[0]);
    final payload = _base64UrlDecode(parts[1]);
    final signature = parts[2];

    return {
      'header': jsonDecode(header),
      'payload': jsonDecode(payload),
      'signature': signature,
    };
  }

  static bool isExpired(String token) {
    final payload = decodeJwt(token)['payload'];

    if (payload.containsKey('exp')) {
      final exp = payload['exp'];
      final now = DateTime.now().millisecondsSinceEpoch / 1000;
      return now > exp;
    } else {
      // If there's no 'exp' claim, we consider the token not expired
      return false;
    }
  }
}
