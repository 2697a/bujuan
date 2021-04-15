import 'package:bujuan/entity/search_singer_entity.dart';
import 'package:bujuan/pages/search/search_detail/search_detail_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';

class SearchAirsitController extends GetxController{
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
    NetUtils().search(SearchDetailController.to.searchContext.value, 100).then((data) {
      if (data is SearchSingerEntity) {
        search
          ..clear()
          ..addAll(data.result.artists);
      }
    });
  }
}