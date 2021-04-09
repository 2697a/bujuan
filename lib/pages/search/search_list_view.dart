import 'package:bujuan/pages/search/search_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchListView extends GetView<SearchListController>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(()=>Text('${controller.search.toJson()}')),
    );
  }

}