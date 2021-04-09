import 'package:bujuan/pages/search/search_detail/search_detail_controller.dart';
import 'package:get/get.dart';

class SearchDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchDetailController>(() => SearchDetailController());
  }

}