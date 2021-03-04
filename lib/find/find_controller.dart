import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:get/get.dart';

class FindController extends GetxController {
  var loadState = 0.obs;
  var result = List<PersonalResult>().obs;

  @override
  void onInit() async {
    await _loadTodaySheet();
    super.onInit();
  }

  _loadTodaySheet() async {
    var personalEntity = await NetUtils().getRecommendResource();
    if (personalEntity != null && personalEntity.code == 200) {
      loadState.value = 2;
      result.addAll(personalEntity.result);
    } else {
      loadState.value = 1;
    }
  }
}
