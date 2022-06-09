import 'dart:async';
import 'dart:io';


import 'netease_cloud_music.dart';
import 'src/module.dart';

export 'src/answer.dart';

typedef DebugPrinter = void Function(String message);

DebugPrinter debugPrint = (msg) {
  print(msg);
};

/// 请求网易云音乐 API
/// API文档地址参考: https://binaryify.github.io/NeteaseCloudMusicApi/#/
Future<Answer> cloudMusicApi(
  String path, {
  Map? parameter,
  List<Cookie> cookie = const [],
}) async {
  assert(handles.containsKey(path), "此 api url 未被定义, 请检查: $path ");
  final handle = handles[path];

  if (handle == null) {
    throw const HttpException('404 not found');
  }

  try {
    final answer = await handle(parameter, cookie);
    return answer;
  } on HttpException catch (e, stack) {
    debugPrint(e.toString());
    debugPrint(stack.toString());
    rethrow;
  }
}
