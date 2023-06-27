import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../home/home_controller.dart';

class PlaylistManager extends GetxController {
  List<Play> playlist = <Play>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    NeteaseMusicApi().userPlayList(Home.to.userData.value.profile?.userId ?? '-1').then((MultiPlayListWrap2 multiPlayListWrap2) async {
      List<Play> list = (multiPlayListWrap2.playlist ?? []);
      if (list.isNotEmpty) {
        playlist..clear()..addAll(list..removeAt(0));
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
