import 'package:bujuan/pages/index/index_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../common/constants/other.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView.builder(
            padding: EdgeInsets.only(left: 40.w,right: 10.w),
            itemBuilder: (context, index) => _buildItem(controller.songs[index], index),
            itemCount: controller.songs.length,
          )),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildItem(SongModel data, int index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w),
        child: Row(
          children: [
            QueryArtworkWidget(
              id: data.id,
              type: ArtworkType.AUDIO,
              artworkBorder: BorderRadius.circular(5.w),
              artworkWidth: 90.w,
              artworkHeight: 90.w,
            ),
            Expanded(
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title,style: TextStyle(fontSize: 28.sp),),
                    Text('${data.artist ?? 'No Artist'} - ${ImageUtils.getTimeStamp(data.duration??0)}',style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.normal),),
                  ],
                ),)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
          ],
        ),
      ),
      onTap: () => controller.play(index),
    );
  }
}
