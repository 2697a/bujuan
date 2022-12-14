import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlayList extends GetView<PlayListController> {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Song Sheet'),),
      body: FutureBuilder<List<MediaItem>>(
          future: controller.getData((context.routeData.args as Play).id),
          builder: (c, s) => DataView<List<MediaItem>>(
              snapshot: s,
              childBuilder: ListView.builder(
                itemBuilder: (context, index) => _buildItem((s.data ?? [])[index], index),
                itemCount: (s.data ?? []).length,
              ))),
    );
  }

  Widget _buildItem(MediaItem data, int index) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      leading: SimpleExtendedImage(
        '${data.extras?['image'] ?? ''}?param=200y200',
        width: 80.w,
        height: 80.w,
      ),
      title: Text(data.title),
      subtitle: Text(data.artist??''),
      onTap: () {
        controller.playIndex(index);
      },
    );
  }
}
