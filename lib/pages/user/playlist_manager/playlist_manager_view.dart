import 'package:bujuan/pages/user/playlist_manager/playlist_manager_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayListManagerView extends GetView<PlayListManagerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歌单管理'),
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(()=>ListView.builder(
                itemBuilder: (context, index) {
                  return Obx(()=>CheckboxListTile(
                    value: controller.delList
                        .contains(controller.playList[index].id),
                    onChanged: (value) {
                      if (controller.delList
                          .contains(controller.playList[index].id)) {
                        controller.delList.remove(controller.playList[index].id);
                      } else {
                        controller.delList.add(controller.playList[index].id);
                      }
                    },title: Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 12.0),
                          child:Card(
                            child: CachedNetworkImage(
                              width: 42,
                              height: 42,
                              imageUrl: '${controller.playList[index].coverImgUrl}?param=100y100',
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 25,
                                  alignment: Alignment.centerLeft,
                                  child: Text(controller.playList[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16.0)),
                                ),
                                Container(
                                  height: 25,
                                  alignment: Alignment.centerLeft,
                                  child: Text('${controller.playList[index].trackCount}首',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                      TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                                )
                              ],
                            )),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 4.0))
                      ],
                    ),
                  ),));
                },
                itemCount: controller.playList.length,
              ))),
          ListTile(
            title: Center(child: Text('删除',style: TextStyle(color: Colors.red),)),
            onTap: ()=>controller.delPlayList(),
          )
        ],
      ),
    );
  }
}
