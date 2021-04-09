import 'package:bujuan/pages/search/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SearchController>(SearchController());
  }

}