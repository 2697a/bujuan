import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/api/play/cloud_entity.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: RichText(
              text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
                TextSpan(text: '云盘～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
              ])),
        ),
        body: RequestWidget<CloudEntity>(
            dioMetaData: controller.cloudSongDioMetaData(limit: 80),
            childBuilder: (data) {
              return RequestWidget<SongDetailWrap>(
                  dioMetaData: songDetailDioMetaData((data.data?.map((e) => '${e.songId??0}').toList()??[])),
                  childBuilder: (playlist) {
                    controller.mediaItems..clear()..addAll((playlist.songs ?? [])
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
                      itemBuilder: (context, index) => _buildItem(controller.mediaItems[index], index),
                      itemCount: controller.mediaItems.length,
                    );
                  });
            }),
      ),
      onHorizontalDragDown: (e){},
    );
  }

  Widget _buildItem(MediaItem data, int index) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      leading: SimpleExtendedImage(
        '${data.extras!['image']}?param=200y200',
        width: 80.w,
        height: 80.w,
      ),
      title: Text(data.title ?? ''),
      subtitle: Text(data.artist ?? ''),
      onTap: () {
        HomeController.to.playByIndex(index, 'cloud',mediaItem: controller.mediaItems);
      },
    );
  }
}
