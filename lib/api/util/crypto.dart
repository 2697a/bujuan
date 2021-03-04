import 'dart:convert';
import 'dart:math' as math;

import 'package:encrypt/encrypt.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';

import 'package:crypto/crypto.dart';

const _keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@visibleForTesting
const publicKey =
    '-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgtQn2JZ34ZC28NWYpAUd98iZ37BUrX/aKzmFbt7clFSs6sXqHauqKWqdtLkF2KexO40H1YTX8z2lSgBBOAxLsvaklV8k4cBFK9snQXE9/DDaFt6Rr7iVZMldczhC0JNgTz+SHXT6CBHuX3e9SdB1Ua44oncaTWz7OBGLbCiK45wIDAQAB\n-----END PUBLIC KEY-----';

const _presetKey = '0CoJUm6Qyw8W8jud';
const _linuxApiKey = 'rFgB&h#%2?^eDg:Q';
const _eapiKey = 'e82ckenh8dichen8';

final IV _iv = IV.fromUtf8('0102030405060708');

///weApi 加密方式
Map<String, String> weApi(Map obj) {
  final text = json.encode(obj);
  final secKey = _createdSecretKey();
  final mode = AESMode.cbc;
  return {
    "params": _aesEncrypt(
            _aesEncrypt(text, mode, _presetKey, _iv).base64, mode, secKey, _iv)
        .base64,
    "encSecKey": rsaEncrypt(_reverse(secKey), publicKey).base16
  };
}

///LinuxApi 加密方式
Map linuxApi(Map obj) {
  final text = json.encode(obj);
  return {
    "eparams":
        _aesEncrypt(text, AESMode.ecb, _linuxApiKey, null).base16.toUpperCase()
  };
}

/// eapi 加密方式
Map eapi(String url, Map obj) {
  final text = json.encode(obj);
  final message = 'nobody${url}use${text}md5forencrypt';
  final digest = md5.convert(utf8.encode(message));
  final data = '${url}-36cd479b6b5-${text}-36cd479b6b5-${digest}';
  return {
    'params':
        _aesEncrypt(data, AESMode.ecb, _eapiKey, null).base16.toUpperCase()
  };
}

/// eapi 接口返回数据解密
String decrypt(List<int> buffer) {
  return Encrypter(AES(Key.fromUtf8(_eapiKey), mode: AESMode.ecb))
      .decrypt(Encrypted(buffer));
}

String _createdSecretKey({int size = 16}) {
  StringBuffer buffer = StringBuffer();
  for (var i = 0; i < size; i++) {
    final position = math.Random().nextInt(_keys.length);
    buffer.write(_keys[position]);
  }
  return buffer.toString();
}

Encrypted _aesEncrypt(String text, AESMode mode, String key, IV iv) {
  final encrypt =
      Encrypter(AES(Key.fromUtf8(key), mode: mode, padding: "PKCS7"));
  return encrypt.encrypt(text, iv: iv);
}

///rsa encrypt with NO_PADDING
@visibleForTesting
Encrypted rsaEncrypt(String text, String key) {
  RSAPublicKey pubKey = RSAKeyParser().parse(key);
  final rsa = RSAEngine();
  rsa.init(true, PublicKeyParameter<RSAPublicKey>(pubKey));
  final encrypted = rsa.process(utf8.encode(text));
  return Encrypted(encrypted);
}

String _reverse(String content) {
  StringBuffer buffer = new StringBuffer();
  for (int i = content.length - 1; i >= 0; i--) {
    buffer.write(content[i]);
  }
  return buffer.toString();
}
