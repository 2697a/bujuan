import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';

class CloudController extends GetxController {
  final List<MediaItem> mediaItems = [];

  DioMetaData cloudSongDioMetaData({int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/v1/cloud/get'), data: params, options: joinOptions());
  }
}
