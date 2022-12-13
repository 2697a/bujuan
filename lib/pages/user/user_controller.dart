import 'package:bujuan/pages/home/home_controller.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';

class UserController extends HomeController {
  List<Play> playlist = <Play>[].obs;
  @override
  void onReady() {
    super.onReady();
    getUserPlayList();
  }

  getUserPlayList() {
    NeteaseMusicApi()
        .userPlayList(userData.value.profile?.userId ?? '-1')
        .then((MultiPlayListWrap2 multiPlayListWrap2) => playlist..clear()..addAll(multiPlayListWrap2.playlist??[]))
        .catchError((error) {

    });
  }
}
