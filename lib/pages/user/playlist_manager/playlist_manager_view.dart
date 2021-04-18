import 'package:bujuan/pages/user/playlist_manager/playlist_manager_controller.dart';
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
                    },title: Text('${controller.playList[index].name}'),));
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
