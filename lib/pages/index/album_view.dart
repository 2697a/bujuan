import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/widget/request_widget/request_loadmore_view.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/api/play/cloud_entity.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/app_bar.dart';
import '../user/user_controller.dart';

class AlbumView extends GetView<IndexController> {
  const AlbumView({Key? key}) : super(key: key);

  DioMetaData songDetailDioMetaData(List<String> songIds) {
    var params = {
      'ids': songIds,
      'c': songIds.map((e) => jsonEncode({'id': e})).toList()
    };
    return DioMetaData(joinUri('/api/v3/song/detail'), data: params, options: joinOptions());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          backgroundColor: Colors.transparent,
          title: RichText(
              text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
            TextSpan(text: '云盘～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
          ])),
        ),
        body: RequestLoadMoreWidget<CloudSongListWrap, CloudSongItem>(
            listKey: const ['data'],
            dioMetaData: controller.cloudSongDioMetaData(),
            childBuilder: (List<CloudSongItem> data) {
              controller.mediaItems
                ..clear()
                ..addAll(data
                    .map((e) => MediaItem(
                        id: e.simpleSong.id,
                        duration: Duration(milliseconds: e.simpleSong.dt ?? 0),
                        artUri: Uri.parse('${e.simpleSong.al?.picUrl ?? ''}?param=500y500'),
                        extras: {
                          'url': '',
                          'image': e.simpleSong.al?.picUrl ?? '',
                          'type': '',
                          'liked': UserController.to.likeIds.contains(int.tryParse(e.simpleSong.id)),
                          'artist': (e.simpleSong.ar ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / ')
                        },
                        title: e.simpleSong.name ?? "",
                        album: jsonEncode(e.simpleSong.al?.toJson()),
                        artist: (e.simpleSong.ar ?? []).map((e) => e.name).toList().join(' / ')))
                    .toList());
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) => _buildItem(controller.mediaItems[index], index),
                itemCount: controller.mediaItems.length,
              );
            }),
      ),
      onHorizontalDragDown: (e) {},
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
      onTap: () => HomeController.to.playByIndex(index, 'cloudSong', mediaItem: controller.mediaItems),
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
