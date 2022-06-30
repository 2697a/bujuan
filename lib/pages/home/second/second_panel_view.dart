// import 'package:audio_service/audio_service.dart';
// import 'package:bujuan/common/constants/other.dart';
// import 'package:bujuan/pages/home/home_controller.dart';
// import 'package:bujuan/widget/lyric/lyrics_reader.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// import '../../../widget/lyric/lyrics_reader_model.dart';
//
// class SecondPanelView extends GetView<HomeController> {
//   const SecondPanelView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Container(
//           width: Get.width,
//           padding: EdgeInsets.only(top: controller.secondPanelHeaderSize + MediaQuery.of(context).padding.bottom),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)), color: controller.rx.value.dark?.color ?? Colors.white),
//           child: PageView(
//             physics: const NeverScrollableScrollPhysics(),
//             controller: controller.secondPageController,
//             children: [
//               _buildPlayList(),
//               _buildLyricList(),
//               Text(''),
//             ],
//           ),
//         ));
//   }
//
//   Widget _buildPlayList() {
//     return NotificationListener<ScrollNotification>(
//         onNotification: (ScrollNotification notification) {
//           controller.offset = notification.metrics.pixels;
//           return false;
//         },
//         child: Listener(
//           onPointerMove: (event) {
//             // 触摸事件过程 手指一直在屏幕上且发生距离滑动
//             if (controller.isScroll.value != !(controller.offset == 0 && event.position.dy > controller.down)) {
//               controller.isScroll.value = !(controller.offset == 0 && event.position.dy > controller.down);
//             }
//           },
//           onPointerUp: (event) {
//             controller.isScroll.value = true;
//           },
//           onPointerDown: (event) {
//             controller.down = event.position.dy;
//           },
//           child: ListView.builder(
//             physics: controller.isScroll.value ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) => _buildPlayListItem(controller.audioServeHandler.queue.value[index], index),
//             itemCount: controller.audioServeHandler.queue.value.length,
//             padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30.w),
//           ),
//         ));
//   }
//
//   Widget _buildPlayListItem(MediaItem audio, int index) {
//     return InkWell(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
//         child: Row(
//           children: [
//             Expanded(
//                 child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   audio.title,
//                   style: TextStyle(color: controller.mediaItem.value.id == audio.id?Theme.of(controller.buildContext).primaryColor:controller.rx.value.dark?.bodyTextColor, fontSize: 24.sp),
//                 ),
//                 Text(
//                   '${audio.artist ?? ''}  ${ImageUtils.getTimeStamp(audio.duration?.inMilliseconds ?? 0)}',
//                   style: TextStyle(color: controller.mediaItem.value.id == audio.id?Theme.of(controller.buildContext).primaryColor:controller.rx.value.dark?.bodyTextColor, fontSize: 24.sp),
//                 )
//               ],
//             )),
//             Offstage(
//               offstage: controller.mediaItem.value.id != audio.id,
//               child: LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(controller.buildContext).primaryColor, size: 38.w),
//             )
//           ],
//         ),
//       ),
//       onTap: () => controller.audioServeHandler.skipToQueueItem(index),
//     );
//   }
//
//   Widget _buildLyricList() {
//     int currPosition = controller.duration.value.inMilliseconds;
//     return Obx(() => ListView.builder(
//           controller: controller.scrollController,
//           physics: controller.isScroll.value ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) =>
//               _buildLyricItem(controller.lyricList[index], currPosition, controller.lyricList[index < controller.lyricList.length - 1 ? index + 1 : index].startTime ?? 0),
//           itemCount: controller.lyricList.length,
//           padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30.w),
//         ));
//   }
//
//   Widget _buildLyricItem(LyricsLineModel lyric, int d, int nextTime) {
//     bool isCurrLine = d >= (lyric.startTime ?? 0) && (d < nextTime);
//     if (lyric.startTime == null) {
//       return Container(
//         height: (Get.height - controller.getSecondPanelMinSize() - controller.panelHeaderSize) / 2,
//       );
//     }
//     return InkWell(
//       child: SizedBox(
//         height: 60.w,
//         child: Row(
//           children: [
//             Text(
//               lyric.mainText ?? '~~',
//               style: TextStyle(color: isCurrLine ? Theme.of(controller.buildContext).primaryColor : controller.rx.value.dark?.bodyTextColor, fontSize: isCurrLine ? 32.sp : 28.sp),
//             ),
//           ],
//         ),
//       ),
//       onTap: () => controller.audioServeHandler.seek(Duration(milliseconds: lyric.startTime ?? 0)),
//     );
//   }
// }
