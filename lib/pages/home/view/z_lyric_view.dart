import 'package:auto_size_text/auto_size_text.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/list_wheel/clickable_list_wheel_widget.dart';

class LyricView extends GetView<HomeController> {
  const LyricView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildLyric(context);
  }

  //歌词
  Widget _buildLyric(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
        child: Visibility(
          visible: controller.lyricsLineModels.isNotEmpty,
          replacement: Center(
            child: Text('暂无歌词～', style: TextStyle(fontSize: 34.sp, color: controller.getPlayPageTheme(context))),
          ),
          child: Listener(
            onPointerDown: (event) {
              controller.onMove.value = true;
            },
            onPointerMove: (event) {
              //手指移动暂停歌词自动滚动
              controller.onMove.value = true;
            },
            onPointerUp: (event) {
              //手指放开 延时三秒开始自动滚动（用户三秒期间可以滑动到指定位置并播放）
              Future.delayed(const Duration(milliseconds: 2500), () => controller.onMove.value = false);
            },
            child: ClickableListWheelScrollView(
              itemHeight: controller.hasTran.value ? 162.w : 90.w,
              itemCount: controller.lyricsLineModels.length,
              onItemTapCallback: (index) {
                //点击歌词
                controller.audioServeHandler.seek(Duration(milliseconds: controller.lyricsLineModels[index].startTime ?? 0));
              },
              scrollController: controller.lyricScrollController,
              child: ListWheelScrollView.useDelegate(
                itemExtent: controller.hasTran.value ? 150.w : 90.w,
                controller: controller.lyricScrollController,
                physics: const ClampingScrollPhysics(),
                overAndUnderCenterOpacity: 0.6,
                perspective: 0.00001,
                onSelectedItemChanged: (index) {
                  //TODO 此处可以获取实时歌词
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) => Container(
                    width: Get.width,
                    height: controller.hasTran.value ? 150.w : 90.w,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          controller.lyricsLineModels[index].mainText ?? '',
                          style: TextStyle(fontSize: controller.hasTran.value ? 30.sp : 32.sp, color: controller.getPlayPageTheme(context)),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Visibility(
                          visible: controller.hasTran.value,
                          child: Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                        ),
                        Visibility(
                            visible: controller.hasTran.value,
                            child: AutoSizeText(controller.lyricsLineModels[index].extText ?? '',
                                style: TextStyle(
                                  fontSize: controller.hasTran.value ? 30.sp : 32.sp,
                                  color: controller.getPlayPageTheme(context),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis))
                      ],
                    ),
                  ),
                  childCount: controller.lyricsLineModels.length,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
