import 'package:bujuan/global/global_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class MusicBottomBarView extends GetView<GlobalController> {
  final WeSlideController weSlideController;

  MusicBottomBarView({this.weSlideController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 3),
      height: 59.0,
      child: Obx(()=>Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
        ),
        elevation: 8,
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 18.0,right: 8.0),
          leading: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(44.0)),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              width: 44.0,
              height: 44.0,
              imageUrl: controller.song.value.musicId!='-99'?'${controller.song.value.iconUri}?param=80y80':'${controller.song.value.iconUri}',
            ),
          ),
          title: Text(
            '${controller.song.value.title}',
            style: TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('${controller.song.value.artist}', style: TextStyle(fontSize: 14.0, color: Colors.grey[500])),
          trailing: Wrap(
            children: [
              IconButton(icon: Icon(controller.playState.value == PlayState.PLAYING ? Icons.pause : Icons.play_arrow), onPressed: () => controller.playOrPause(), color: Theme.of(Get.context).bottomAppBarColor),
              IconButton(icon: Icon(Icons.skip_next), onPressed: () => controller.skipToNext(), color: Theme.of(Get.context).bottomAppBarColor),
            ],
          ),
          onTap: ()=>weSlideController?.show(),
        ),
      )),
    );
  }
}