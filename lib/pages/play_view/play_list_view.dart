import 'package:bujuan/global/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayListView extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 14.0, right: 3.0),
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '播放列表(${controller.playList.length})',
                style:
                TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(Icons.location_searching, size: 24.0),
                  onPressed: ()=>controller.scrollToIndex())
            ],
          ),
        ),
        Container(
          color: Theme.of(Get.context).bottomAppBarColor.withAlpha(60),
          height: .2,
        ),
        Expanded(
            child: Obx(()=>ListView.builder(
              controller: controller.scrollController,
              itemBuilder: (context, index) => _buildPlayListItem(index),
              itemCount: controller.playList.length,
            )))
      ],
    );
  }

  Widget _buildPlayListItem(index) {

    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        height: 52.0,
        child: Row(
          children: [
            IconButton(icon: Text('${index + 1}'), onPressed: () {}),
            Container(
              constraints: BoxConstraints(
                maxWidth: Get.width / 2.8,
              ),
              child: Text(
                '${controller.playList[index].title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: controller.song.value.musicId ==
                          controller.playList[index].musicId
                      ? Theme.of(Get.context).accentColor
                      : Theme.of(Get.context).bottomAppBarColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
                child: Text(
              ' -  ${controller.playList[index].artist}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: controller.song.value.musicId ==
                        controller.playList[index].musicId
                    ? Theme.of(Get.context).accentColor
                    : Colors.grey[500],
              ),
            )),
            IconButton(
                icon: Icon(Icons.delete_outline_outlined, size: 20.0),
                onPressed: () {})
          ],
        ),
      ),
      onTap: () =>controller.playMusicByIndex(index),
    );
  }
}
