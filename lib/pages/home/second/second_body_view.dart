import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/other.dart';

class SecondBodyView extends GetView<HomeController> {
  const SecondBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.isPlaying(
        player: controller.assetsAudioPlayer,
        builder: (context, playing) => PlayerBuilder.current(
            player: controller.assetsAudioPlayer,
            builder: (c, p) => Obx(() => Opacity(
                  opacity: controller.slidePosition.value,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.w),
                        child: SizedBox(height: controller.getPanelMinSize() + controller.getPanelAdd()),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                p.audio.audio.metas.title ?? '',
                                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold, color: controller.rx.value.dark?.bodyTextColor),
                                maxLines: 1,
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                              Text(
                                p.audio.audio.metas.artist ?? '',
                                style: TextStyle(fontSize: 28.sp, color: controller.rx.value.dark?.bodyTextColor),
                                maxLines: 1,
                              )
                            ],
                          )),
                        ],
                      ),
                      _buildSlide(p),
                      _buildPlayController(playing)
                    ],
                  ),
                ))));
  }

  Widget _buildSlide(Playing p) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: PlayerBuilder.currentPosition(
          player: controller.assetsAudioPlayer,
          builder: (context, position) => Column(
                children: [
                  SizedBox(
                    child: SliderTheme(
                        data: SliderThemeData(
                            activeTrackColor: controller.rx.value.dark?.bodyTextColor,
                            trackHeight: 3.w,
                            thumbShape: RoundSliderThumbShape(elevation: 0, enabledThumbRadius: 3.w),
                            thumbColor: Colors.transparent),
                        child: Slider(
                            value: position.inMilliseconds / p.audio.duration.inMilliseconds * 100,
                            max: 100,
                            onChanged: (value) {
                              controller.assetsAudioPlayer.seek(Duration(milliseconds: p.audio.duration.inMilliseconds * value ~/ 100));
                            })),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ImageUtils.getTimeStamp(position.inMilliseconds),
                          style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 32.sp),
                        ),
                        Text(
                          ImageUtils.getTimeStamp(p.audio.duration.inMilliseconds),
                          style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 32.sp),
                        ),
                      ],
                    ),
                  )
                ],
              )),
    );
  }

  Widget _buildPlayController(bool isPlay) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => controller.assetsAudioPlayer.previous(),
              icon: Icon(
                Icons.skip_previous,
                size: 60.w,
                color: controller.rx.value.dark?.bodyTextColor,
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: InkWell(
              child: Icon(
                isPlay ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 140.w,
                color: controller.rx.value.dark?.bodyTextColor.withOpacity(.6),
              ),
              onTap: () => controller.playOrPause(),
            ),
          ),
          IconButton(
              onPressed: () => controller.assetsAudioPlayer.next(),
              icon: Icon(
                Icons.skip_next,
                size: 60.w,
                color: controller.rx.value.dark?.bodyTextColor,
              )),
        ],
      ),
    ));
  }
}
