import 'package:bujuan/pages/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Card(
            child: InkWell(
              child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),child: Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
                  Icon( const IconData(0xe61b, fontFamily: 'iconfont')),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                  Text('点击搜索')
                ],
              ),),
              onTap: ()=>Get.toNamed('/search_details',arguments: {'content':''}),),
            ),
          Expanded(
              child: Obx(() => CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Text(
                            "搜索推荐",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: controller.searchList.length>0?controller.searchList
                              .map((e) => Card(
                            margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                                    child: InkWell(child: Container(
                                      child: Text(e.searchWord),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15.0),
                                    ),onTap: ()=>Get.toNamed('/search_details',arguments: {'content':'${e.searchWord}'}),),
                                  ))
                              .toList():controller.searchListTest.map((e) => e).toList(),
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
