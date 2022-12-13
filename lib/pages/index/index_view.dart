import 'package:bujuan/pages/home/first/first_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../common/constants/other.dart';
import '../../widget/simple_extended_image.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => ListView.builder(
            padding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: FirstController.to.getHomeBottomPadding()),
            itemBuilder: (context, index) => _buildItem(controller.songs[index], index),
            itemCount: controller.songs.length,
          )),
    );
  }

  Widget _buildItem(SongModel data, int index) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.w),
        padding: EdgeInsets.symmetric(vertical: 15.w),
        child: Row(
          children: [
            SimpleExtendedImage('${HomeController.to.directoryPath}${data.albumId}',cacheWidth: 200,width: 90.w,height: 90.w,),
            Expanded(
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title,style: TextStyle(fontSize: 28.sp),),
                    Text('${data.artist ?? 'No Artist'} - ${ImageUtils.getTimeStamp(data.duration??0)}',style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.normal),),
                  ],
                ),)),
          ],
        ),
      ),
      onTap: () => controller.play(index),
    );
  }
}
