import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SecondPanelView extends GetView<HomeController> {
  const SecondPanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: Get.width,
          padding: EdgeInsets.only(top: controller.secondPanelHeaderSize + MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)), color: controller.rx.value.dark?.color ?? Colors.white),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.secondPageController,
            children: [
              _buildPlayList(),
              _buildLyricList(),
              Text(controller.lyric.value),
            ],
          ),
        ));
  }

  Widget _buildPlayList() {
    List<Audio> audios = controller.assetsAudioPlayer.playlist?.audios ?? [];
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          controller.offset = notification.metrics.pixels;
          return false;
        },
        child: Listener(
          onPointerMove: (event) {
            // 触摸事件过程 手指一直在屏幕上且发生距离滑动
            if (controller.isScroll.value != !(controller.offset == 0 && event.position.dy > controller.down)) {
              controller.isScroll.value = !(controller.offset == 0 && event.position.dy > controller.down);
            }
          },
          onPointerUp: (event) {
            controller.isScroll.value = true;
          },
          onPointerDown: (event) {
            controller.down = event.position.dy;
          },
          child: PlayerBuilder.current(
              player: controller.assetsAudioPlayer,
              builder: (context, playing) => ListView.builder(
                    physics: controller.isScroll.value ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => _buildPlayListItem(audios[index], index, playing),
                    itemCount: audios.length,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30.w),
                  )),
        ));
  }

  Widget _buildPlayListItem(Audio audio, int index, Playing playing) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audio.metas.title ?? '',
                  style: TextStyle(color: controller.rx.value.dark?.bodyTextColor),
                ),
                Text(
                  audio.metas.artist ?? '',
                  style: TextStyle(color: controller.rx.value.dark?.bodyTextColor),
                )
              ],
            )),
            Icon(playing.audio.audio.metas.id == audio.metas.id ? Icons.play_arrow : null, color: controller.rx.value.dark?.bodyTextColor)
          ],
        ),
      ),
      onTap: () => controller.assetsAudioPlayer.playlistPlayAtIndex(index),
    );
  }

  Widget _buildLyricList() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          controller.offset = notification.metrics.pixels;
          return false;
        },
        child: Listener(
          onPointerMove: (event) {
            // 触摸事件过程 手指一直在屏幕上且发生距离滑动
            if (controller.isScroll.value != !(controller.offset == 0 && event.position.dy > controller.down)) {
              controller.isScroll.value = !(controller.offset == 0 && event.position.dy > controller.down);
            }
          },
          onPointerUp: (event) {
            controller.isScroll.value = true;
          },
          onPointerDown: (event) {
            controller.down = event.position.dy;
          },
          child: ListView.builder(
            physics: controller.isScroll.value ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _buildLyricItem((controller.lyric.value).split('\n')[index]),
            itemCount: (controller.lyric.value).split('\n').length,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30.w),
          ),
        ));
  }

  Widget _buildLyricItem(String lyric) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
        child: Text(
          lyric,
          style: TextStyle(color: controller.rx.value.dark?.bodyTextColor),
        ),
      ),
    );
  }
}
