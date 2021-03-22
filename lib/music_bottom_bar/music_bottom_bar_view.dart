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
      height: 65.0,
      child: Obx(()=>Card(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        margin: EdgeInsets.all(0),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          leading: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(46.0)),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              width: 46.0,
              height: 46.0,
              imageUrl: '${controller.song.value.iconUri}?param=80y80',
            ),
          ),
          title: Text(
            '${controller.song.value.title}',
            style: TextStyle(fontSize: 14.0),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('${controller.song.value.artist}', style: TextStyle(fontSize: 15.0, color: Colors.grey[500])),
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