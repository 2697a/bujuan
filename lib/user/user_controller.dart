import 'package:bujuan/entity/login_entity.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var isLogin = false.obs;
  var loadState = 0.obs;
  var userProfile = UserProfileEntity().obs;
  var playList = List<UserOrderPlaylist>().obs;

  @override
  void onInit() {
    var userId = SpUtil.getString(USER_ID_SP, defValue: null);
    if (userId != null) {
      isLogin.value = true;
      // getUserProfile(userId);
      getUserSheet();
    }
    super.onInit();
  }

  ///更改登录状态
  changeLoginState(bool isLogin, LoginEntity userProfile) {
    this.isLogin.value = true;
    // if (isLogin) getUserProfile(userProfile.profile.userId);
    if (isLogin) getUserSheet();
  }

  ///获取用户资料
  getUserProfile(userId) async {
    var userProfileEntity = await NetUtils().getUserProfile(userId);
    if (userProfileEntity != null && userProfileEntity.code == 200) {
      userProfile.value = userProfileEntity;
      loadState.value = 2;
    } else {
      loadState.value = 1;
    }
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
