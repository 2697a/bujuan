import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/list_wheel/clickable_list_wheel_widget.dart';

class LyricView extends GetView<Home> {
  const LyricView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildLyric(context);
  }

  //歌词
  Widget _buildLyric(BuildContext context) {
    return ClassStatelessWidget(
      child: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
          child: Visibility(
            visible: controller.lyricsLineModels.isNotEmpty,
            replacement: Center(
              child: Text('暂无歌词～', style: TextStyle(fontSize: 34.sp, color: controller.bodyColor.value)),
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
              child: Obx(() => ClickableListWheelScrollView(
                itemHeight: controller.hasTran.value ? 300.w : 140.w,
                itemCount: controller.lyricsLineModels.length,
                onItemTapCallback: (index) {
                  //点击歌词
                  controller.audioServeHandler.seek(Duration(milliseconds: controller.lyricsLineModels[index].startTime ?? 0));
                },
                scrollController: controller.lyricScrollController,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: controller.hasTran.value ? 300.w : 140.w,
                  controller: controller.lyricScrollController,
                  physics: const FixedExtentScrollPhysics(),
                  perspective: 0.0006,
                  onSelectedItemChanged: (index) {
                    controller.currLyricIndex.value = index;
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) => Obx(() => Container(
                      width: Get.width,
                      height: controller.hasTran.value ? 300.w : 140.w,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => Text(
                            controller.lyricsLineModels[index].mainText ?? '',
                            style: TextStyle(fontSize: controller.hasTran.value ? 52.sp : 52.sp, color: controller.bodyColor.value.withOpacity(controller.currLyricIndex.value == index?0.8:.4)),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Visibility(
                            visible: controller.hasTran.value,
                            child: Padding(padding: EdgeInsets.symmetric(vertical: 4.w)),
                          ),
                          Visibility(
                              visible: controller.hasTran.value,
                              child: Obx(() => Text(controller.lyricsLineModels[index].extText ?? '',
                                  style: TextStyle(
                                    fontSize: 42.sp,
                                    color: controller.bodyColor.value.withOpacity(controller.currLyricIndex.value == index?0.8:.4),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis)))
                        ],
                      ),
                    )),
                    childCount: controller.lyricsLineModels.length,
                  ),
                ),
              )),
            ),
          ),
        );
      }),
    );
  }
}
