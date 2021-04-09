import 'package:bujuan/pages/search/search_mv/search_mv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchMvView extends GetView<SearchMvController>{
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Text('${controller.search[index].name}'),
          );
        }, itemCount: controller.search.length));
  }

}