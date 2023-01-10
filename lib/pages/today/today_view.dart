import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/simple_extended_image.dart';
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
        appBar: AppBar(title: const Text('每日'),
          backgroundColor: Colors.transparent,),
        body: RequestWidget<RecommendSongListWrapX>(
            dioMetaData: recommendSongListDioMetaData(),
            childBuilder: (playlist) {
              _mediaItem
                ..clear()
                ..addAll((playlist.data.dailySongs ?? [])
                    .map((e) => MediaItem(
                    id: e.id,
                    duration: Duration(milliseconds: e.dt ?? 0),
                    artUri: Uri.parse('${e.al?.picUrl ?? ''}?param=500y500'),
                    extras: {
                      'url': '',
                      'image': e.al?.picUrl ?? '',
                      'type': '',
                      'liked': UserController.to.likeIds.contains(int.tryParse(e.id)),
                      'artist': (e.ar ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / ')
                    },
                    title: e.name ?? "",
                    album: jsonEncode(e.al?.toJson()),
                    artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
                    .toList());
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) => _buildItem(_mediaItem[index],index),
                itemCount: _mediaItem.length,
              );
            }),
      ),
      onHorizontalDragDown: (e){},
    );
  }


  Widget _buildItem(MediaItem data, int index) {
    return InkWell(
      child: SizedBox(
        height: 120.w,
        child: Row(
          children: [
            SimpleExtendedImage(
              '${data.extras?['image'] ?? ''}?param=200y200',
              width: 85.w,
              height: 85.w,
              borderRadius: BorderRadius.circular(10.w),
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.title,
                        maxLines: 1,
                        style: TextStyle(fontSize: 28.sp),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                      Text(
                        data.artist ?? '',
                        style: TextStyle(fontSize: 26.sp, color: Colors.grey),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
      onTap: () => HomeController.to.playByIndex(index, (context.routeData.args as Play).id, mediaItem: _mediaItem),
    );
    // return ListTile(
    //   dense: true,
    //   contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
    //   leading: SimpleExtendedImage(
    //     '${data.extras?['image'] ?? ''}?param=200y200',
    //     width: 80.w,
    //     height: 80.w,
    //   ),
    //   title: Text(data.title),
    //   subtitle: Text(data.artist??''),
    //   onTap: () {
    //     controller.playIndex(index);
    //   },
    // );
  }
}
