import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindController extends GetxController {
  var loadState = 0.obs;
  var result = List<PersonalResult>().obs;
  RefreshController refreshController;
  @override
  void onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  @override
  void onReady() {
    loadTodaySheet();
    super.onReady();
  }

  loadTodaySheet() async {
    var personalEntity = await NetUtils().getRecommendResource();
    if (personalEntity != null && personalEntity.code == 200) {
      loadState.value = 2;
      result..clear()..addAll(personalEntity.result);
    } else {
      loadState.value = 1;
    }
    refreshController?.refreshCompleted();
  }
}
