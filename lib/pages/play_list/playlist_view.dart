import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/request_widget/request_view.dart';
import '../../widget/simple_extended_image.dart';
import '../home/home_controller.dart';

class PlayListView extends StatefulWidget {
  const PlayListView({Key? key}) : super(key: key);

  @override
  State<PlayListView> createState() => _PlayListViewState();
}

class _PlayListViewState extends State<PlayListView> {
  DioMetaData playListDetailDioMetaData(String categoryId, {int subCount = 5}) {
    var params = {'id': categoryId, 'n': 1000, 's': '$subCount', 'shareUserId': '0'};
    return DioMetaData(Uri.parse('https://music.163.com/api/v6/playlist/detail'), data: params, options: joinOptions());
  }

  DioMetaData songDetailDioMetaData(List<String> songIds) {
    var params = {
      'ids': songIds,
      'c': songIds.map((e) => jsonEncode({'id': e})).toList()
    };
    return DioMetaData(joinUri('/api/v3/song/detail'), data: params, options: joinOptions());
  }

  final List<MediaItem> _mediaItem = [];

  // _playIndex(int index) async {
  //   String title = HomeController.to.audioServeHandler.queueTitle.value;
  //   if (title.isEmpty || title != (context.routeData.args as Play).id) {
  //     HomeController.to.audioServeHandler.queueTitle.value = (context.routeData.args as Play).id;
  //     HomeController.to.audioServeHandler
  //       ..changeQueueLists(_mediaItem, index: index)
  //       ..playIndex(index);
  //   } else {
  //     HomeController.to.audioServeHandler.playIndex(index);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Song Sheet'),
          backgroundColor: Colors.transparent,
        ),
        body: RequestWidget<SinglePlayListWrap>(
            dioMetaData: playListDetailDioMetaData((context.routeData.args as Play).id),
            childBuilder: (SinglePlayListWrap data) => RequestWidget<SongDetailWrap>(
                dioMetaData: songDetailDioMetaData((data.playlist?.trackIds ?? []).map((e) => e.id).toList()),
                childBuilder: (playlist) {
                  _mediaItem
                    ..clear()
                    ..addAll((playlist.songs ?? [])
                        .map((e) => MediaItem(
                            id: e.id,
                            duration: Duration(milliseconds: e.dt ?? 0),
                            artUri: Uri.parse('${e.al.picUrl ?? ''}?param=500y500'),
                            extras: {
                              'url': '',
                              'image': e.al.picUrl ?? '',
                              'type': '',
                              'liked': UserController.to.likeIds.contains(int.tryParse(e.id)),
                              'artist': (e.ar ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / ')
                            },
                            title: e.name ?? "",
                            album: jsonEncode(e.al.toJson()),
                            artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
                        .toList());
                  return ListView.builder(
                    itemExtent: 120.w,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemBuilder: (context, index) => _buildItem(_mediaItem[index], index),
                    itemCount: _mediaItem.length,
                  );
                })),
      ),
      onHorizontalDragDown: (e) {
        return;
      },
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
      onTap: () => HomeController.to.playByIndex(index, (context.routeData.args as Play).id,mediaItem: _mediaItem),
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
