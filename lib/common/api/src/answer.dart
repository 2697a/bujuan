import 'dart:io';

class Answer {
  final int status;
  final Map body;
  final List<Cookie> cookie;

  const Answer(
      {this.status = 500,
      this.body = const {'code': 500, 'msg': 'server error'},
      this.cookie = const []});

  Answer copy({int? status, Map? body, List? cookie}) {
    return Answer(
        status: status ?? this.status,
        body: body ?? this.body,
        cookie: cookie as List<Cookie>? ?? this.cookie);
  }
}
