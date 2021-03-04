import 'dart:async';
import 'dart:io';

import 'answer.dart';
import 'module.dart';



typedef DebugPrinter = void Function(String message);

DebugPrinter debugPrint = (msg) {
  print(msg);
};

/// 请求网易云音乐 API
/// API文档地址参考: https://binaryify.github.io/NeteaseCloudMusicApi/#/
Future<Answer> cloudMusicApi(
  String path, {
  Map parameter,
  List<Cookie> cookie = const [],
}) async {
  assert(path != null, "path can not be null");
  assert(handles.containsKey(path), "此 api url 未被定义, 请检查: $path ");
  final Handler handle = handles[path];

  try {
    final answer = await handle(parameter, cookie);
    return answer;
  } on HttpException catch (e, stack) {
    debugPrint(e.toString());
    debugPrint(stack.toString());
    rethrow;
  }
}
