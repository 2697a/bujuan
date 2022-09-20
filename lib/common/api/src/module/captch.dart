part of '../module.dart';

//注册账号
Handler captch_register = (query, cookie) {
  final data = {
    'captcha': query!['captcha'],
    'phone': query['phone'],
    'password': Encrypted(Uint8List.fromList(
            md5.convert(utf8.encode(query['password'])).bytes))
        .base16,
    'nickname': query['nickname']
  };
  return request('POST', 'https://music.163.com/weapi/register/cellphone', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 发送验证码
Handler captch_send = (query, cookie) {
  final data = {
    'ctcode': query!['ctcode'] ?? '86',
    'cellphone': query['phone'],
  };
  return request('POST', 'https://music.163.com/weapi/sms/captcha/sent', data,
      crypto: Crypto.weapi, cookies: cookie);
};

//校验验证码
Handler captch_verify = (query, cookie) {
  final data = {
    'ctcode': query!['ctcode'] ?? '86',
    'cellphone': query['phone'],
    'captcha': query['captcha']
  };
  return request('POST', 'https://music.163.com/weapi/sms/captcha/verify', data,
      crypto: Crypto.weapi, cookies: cookie);
};
