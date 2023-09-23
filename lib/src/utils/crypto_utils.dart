import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

/// md5 加密
String md5(String source) {
  var bytes = utf8.encode(source);
  return crypto.md5.convert(bytes).toString();
}

/// sha1 加密
String sha1(String source) {
  var bytes = utf8.encode(source);
  return crypto.sha1.convert(bytes).toString();
}

/// rsa 加密
String rsaEncode(String value, String key) {
  RSAKeyParser rsaKeyParser = RSAKeyParser();
  RSAAsymmetricKey rsaPublicKey = rsaKeyParser.parse(key);
  Encrypter encrypt = Encrypter(RSA(publicKey: rsaPublicKey as RSAPublicKey));
  return encrypt.encrypt(value).base64;
}
