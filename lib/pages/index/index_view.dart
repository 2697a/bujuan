import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../common/bean/personalized_entity.dart';
import '../../common/constants/other.dart';
import '../../widget/request_widget.dart';
import '../../widget/simple_extended_image.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
              artworkBorder: BorderRadius.circular(10.w),
              artworkWidth: 80.w,
              artworkHeight: 80.w,
            ),
            Expanded(
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title,style: TextStyle(fontSize: 26.sp,fontWeight: FontWeight.bold),),
                    Text(data.artist ?? 'No Artist',style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.normal),),
                  ],
                ),)),
            Text( ImageUtils.getTimeStamp(data.duration??0),)
          ],
        ),
      ),
      onTap: () => controller.play(index),
    );
  }
}
