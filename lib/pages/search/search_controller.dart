import 'package:bujuan/pages/search/search_list_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final searchList = [].obs;
  TextEditingController textEditingController;
  @override
  void onInit() {
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    getSearchList();
    super.onReady();
  }

  getSearchList() {
    NetUtils().searchList().then((value) {
      searchList
        ..clear()
        ..addAll(value.data);
    });
  }

  onPageChange(index) {
    switch (index) {
      case 0:
        SearchListController.to.getSearch('content', 1);
        break;
      case 1:
        SearchListController.to.getSearch('content', 10);
        break;
      case 2:
        SearchListController.to.getSearch('content', 1000);
        break;
      case 3:
        SearchListController.to.getSearch('content', 1002);
        break;
      case 4:
        SearchListController.to.getSearch('content', 1004);
        break;
    }
  }
}
