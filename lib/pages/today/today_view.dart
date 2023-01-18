import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:keframe/keframe.dart';

import '../../common/constants/other.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../routes/router.gr.dart';
import '../../widget/simple_extended_image.dart';
import '../play_list/playlist_view.dart';
import '../user/user_controller.dart';

class TodayView extends StatefulWidget {
  const TodayView({Key? key}) : super(key: key);

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  DioMetaData recommendSongListDioMetaData() {
    return DioMetaData(joinUri('/api/v3/discovery/recommend/songs'), data: {}, options: joinOptions(cookies: {'os': 'ios'}));
  }

  final List<MediaItem> _mediaItem = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('每日'),
          backgroundColor: Colors.transparent,
        ),
        body: RequestWidget<RecommendSongListWrapX>(
            dioMetaData: recommendSongListDioMetaData(),
            childBuilder: (playlist) {
              _mediaItem
                ..clear()
                ..addAll(HomeController.to.song2ToMedia((playlist.data.dailySongs ?? [])));
              return ListView.builder(
                itemExtent: 120.w,
                itemBuilder: (context, index) => SongItem(index: index, mediaItems: _mediaItem,queueTitle: 'today${DateTime.now().millisecondsSinceEpoch}',),
                itemCount: _mediaItem.length,
              );
            }),
      ),
      onHorizontalDragDown: (e) {},
    );
  }

  // Widget _buildItem(MediaItem data, int index) {
  //   return FrameSeparateWidget(
  //     index: index,
  //     child: InkWell(
  //       key: Key(data.id),
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 30.w),
  //         height: 120.w,
  //         child: Row(
  //           children: [
  //             Expanded(
  //                 child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   data.title,
  //                   maxLines: 1,
  //                   style: TextStyle(fontSize: 30.sp),
  //                 ),
  //                 Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
  //                 Text(
  //                   data.artist ?? '',
  //                   maxLines: 1,
  //                   style: TextStyle(fontSize: 24.sp, color: Colors.grey),
  //                 )
  //               ],
  //             )),
  //             Visibility(
  //               visible: (data.extras!['mv'] ?? 0) != 0,
  //               child: IconButton(
  //                   onPressed: () {
  //                     context.router.push(const MvView().copyWith(queryParams: {'mvId': data.extras?['mv'] ?? 0}));
  //                   },
  //                   icon: const Icon(
  //                     TablerIcons.brand_youtube,
  //                     color: Colors.grey,
  //                   )),
  //             ),
  //             Visibility(
  //               visible: index != null,
  //               replacement: IconButton(
  //                   onPressed: () {},
  //                   icon: const Icon(
  //                     TablerIcons.arrows_move_vertical,
  //                     color: Colors.grey,
  //                   )),
  //               child: IconButton(
  //                   onPressed: () {
  //                     showModalActionSheet(
  //                       context: context,
  //                       title: data.title,
  //                       message: data.artist,
  //                       actions: [const SheetAction<String>(label: '下一首播放', icon: TablerIcons.player_play, key: 'next')],
  //                     ).then((value) {
  //                       if (value != null) {
  //                         if (HomeController.to.audioServeHandler.playbackState.value.queueIndex != 0) {
  //                           HomeController.to.audioServeHandler.insertQueueItem(HomeController.to.audioServeHandler.playbackState.value.queueIndex! + 1, data);
  //                           WidgetUtil.showToast('已添加到下一曲');
  //                         } else {
  //                           WidgetUtil.showToast('未知错误');
  //                         }
  //                       }
  //                     });
  //                   },
  //                   icon: const Icon(
  //                     TablerIcons.dots_vertical,
  //                     color: Colors.grey,
  //                   )),
  //             ),
  //           ],
  //         ),
  //       ),
  //       onTap: () {
  //         HomeController.to.playByIndex(index, (context.routeData.args as Play).id, mediaItem: _mediaItem);
  //       },
  //     ),
  //   );
  // }
}


