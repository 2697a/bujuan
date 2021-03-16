import 'package:bujuan/entity/login_entity.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var loadState = 0.obs;
  var userProfile = UserProfileEntity().obs;
  var playList = List<UserOrderPlaylist>().obs;

  @override
  void onInit() {
    if (Get.find<HomeController>().login.value) {
      // getUserProfile(userId);
      getUserSheet();
    }
    super.onInit();
  }

  ///获取用户歌单
  getUserSheet() async {
    var userId = SpUtil.getString(USER_ID_SP, defValue: null);
    var userOrderEntity = await NetUtils().getUserPlayList(userId);
    if (userOrderEntity != null && userOrderEntity.code == 200) {
      playList.addAll(userOrderEntity.playlist);
      loadState.value = 2;
    }else{
      loadState.value = 1;
    }
  }
}
