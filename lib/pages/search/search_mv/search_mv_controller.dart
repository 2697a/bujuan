import 'package:bujuan/entity/search_mv_entity.dart';
import 'package:bujuan/pages/search/search_detail/search_detail_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';

class SearchMvController extends GetxController{
  final search = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getSearch();
    super.onReady();
  }

  getSearch() {
    NetUtils().search(SearchDetailController.to.searchContext.value, 1004).then((data) {
      if (data is SearchMvEntity) {
        search
          ..clear()
          ..addAll(data.result.mvs);
      }
    });
  }
}