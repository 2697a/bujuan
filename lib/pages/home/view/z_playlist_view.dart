import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class PlayListView extends GetView<HomeController> {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPlayList(context);
  }

  //播放列表
  Widget buildPlayList(BuildContext context) {
    return ClassWidget(child: Obx(() {
      return Visibility(
        visible: !controller.fm.value,
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          controller: controller.playListScrollController,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          itemExtent: 110.w,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            alignment: Alignment.centerLeft,
            child: ClassStatelessWidget(child: _buildPlayListItem(controller.mediaItems[index], index, context)),
          ),
          itemCount: controller.mediaItems.length,
        ),
      );
    }));
  }

  Widget _buildPlayListItem(MediaItem mediaItem, int index, BuildContext context) {
    return InkWell(
      child: Obx(() {
        return SizedBox(
          width: Get.width,
          height: 110.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mediaItem.title,
                        maxLines: 1,
                        style: TextStyle(fontSize: 30.sp, color: controller.bodyColor.value),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 4.w)),
                      Text(
                        mediaItem.artist ?? '',
                        maxLines: 1,
                        style: TextStyle(fontSize: 24.sp, color: controller.bodyColor.value),
                      )
                    ],
                  )),
              Visibility(
                visible: controller.mediaItem.value.id == mediaItem.id,
                child:  Icon(TablerIcons.circle_letter_p,color: controller.bodyColor.value,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
              IconButton(
                  onPressed: () => controller.audioServeHandler.removeQueueItemAt(index),
                  icon: Icon(
                    TablerIcons.trash_x,
                    color: controller.bodyColor.value,
                    size: 42.w,
                  ))
            ],
          ),
        );
      }),
      onTap: () => controller.audioServeHandler.playIndex(index),
    );
  }
}
