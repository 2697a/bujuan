import 'package:bujuan/pages/search/search_list_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final searchList = [].obs;
  final searchListTest = List.generate(
      20,
      (index) => Card(
        child: PlaceholderLines(
          lineHeight: 10.0,
          maxWidth: .5,
          minWidth: .3,
          color: Colors.grey[400],
          count: 1,
        ),
      ));
  bool isLoad = false;

  static SearchController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getSearchList() {
    NetUtils().searchList().then((value) {
      searchList
        ..clear()
        ..addAll(value.data);
      isLoad = true;
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
