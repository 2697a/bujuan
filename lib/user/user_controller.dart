import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserController extends GetxController {
  var playList = [].obs;
   RefreshController refreshController;
   SlidableController slidableController;
  @override
  void onInit() {
    refreshController = RefreshController();
    slidableController = SlidableController();
    super.onInit();
  }
  @override
  void onReady() {
      _getUserSheet();
    super.onReady();
  }

  ///获取用户歌单
  _getUserSheet() async {
    var userId = SpUtil.getString(USER_ID_SP, defValue: null);
    var userOrderEntity = await NetUtils().getUserPlayList(userId);
    if (userOrderEntity != null && userOrderEntity.code == 200) {
      playList.addAll(userOrderEntity.playlist);
    }
    refreshController.refreshCompleted();
  }
}
