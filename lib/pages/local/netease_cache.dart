import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/local/netease_controller.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:bujuan/widget/my_get_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/app_bar.dart';
import '../home/home_controller.dart';
import '../play_list/playlist_view.dart';

class NeteaseCacheView extends GetView<Netease> {
  const NeteaseCacheView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return MyGetView(child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        title: const Text('网易云缓存'),
      ),
      body: Obx(() => Visibility(visible: !controller.loading.value,
        replacement: const LoadingView(tips: '正在解密缓存文件...',),
        child: ListView.builder(
          itemBuilder: (context, index) => SongItem(index: index, mediaItem: controller.mediaItems[index], onTap: (){
            Home.to.playByIndex(index, 'queueTitle', mediaItem: controller.mediaItems);
          },),
          itemCount: controller.mediaItems.length,
          itemExtent: 120.w,
        ),)),
    ));
  }

  Widget _buildItem(MediaItem mediaItem, int index, context) {
    return ListTile(
      title: Text(
        mediaItem.title,
        maxLines: 1,
      ),
      subtitle: Text(
        mediaItem.artist ?? '',
        maxLines: 1,
      ),
      onTap: () {
        Home.to.playByIndex(index, 'queueTitle', mediaItem: controller.mediaItems);
      },
    );
    // return InkWell(
    //   child: Container(
    //     padding: EdgeInsets.only(left: 30.w),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           mediaItem.title,
    //           maxLines: 1,
    //           style: TextStyle(fontSize: 30.sp),
    //         ),
    //         const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
    //         Text(
    //           mediaItem.artist ?? '',
    //           maxLines: 1,
    //           style: TextStyle(fontSize: 24.sp, color: Colors.grey),
    //         )
    //       ],
    //     ),
    //   ),
    //   onTap: (){
    //     HomeController.to.playByIndex(index, 'queueTitle', mediaItem: controller.mediaItems);
    //   },
    // );
  }
}
