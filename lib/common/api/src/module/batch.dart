part of '../module.dart';

Handler batch = (query, cookie) {
  final data = {"e_r": true};
  query!.forEach((key, value) {
    if (RegExp(r"^\/api\/").hasMatch(key)) {
      data[key] = query[key];
    }
  });
  return request('POST', 'http://music.163.com/eapi/batch', data,
      crypto: Crypto.eapi, cookies: cookie);
};
