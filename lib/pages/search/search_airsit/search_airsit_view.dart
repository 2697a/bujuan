import 'package:bujuan/pages/search/search_airsit/search_airsit_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAirsittView extends GetView<SearchAirsitController>{
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              height: 60.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 12.0),
                    child: Hero(
                      tag: '${controller.search[index].id}',
                      child: Card(
                        child: CachedNetworkImage(
                          width: 48,
                          height: 48,
                          imageUrl: '${controller.search[index].img1v1Url}?param=200y200',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(controller.search[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                          Container(
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text('${controller.search[index].albumSize}专辑',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                          )
                        ],
                      )),
                ],
              ),
            ),
            onTap: () {
              // Get.toNamed('/sheet', arguments: {
              //   'id': controller.search[index].id,
              //   'name': controller.search[index].name,
              //   'imageUrl': '${controller.search[index].coverImgUrl}?param=300y300'
              // });
            },
          );
        }, itemCount: controller.search.length));
  }

}