import 'package:bujuan/pages/details/details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../common/constants/other.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           Stack(
             children: [
               AppBar(backgroundColor: Colors.transparent,)
             ],
           ),
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  itemBuilder: (context, index) =>
                      _buildItem(controller.songs[index], index),
                  itemCount: controller.songs.length,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(SongModel data, int index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(fontSize: 28.sp),
                  ),
                  Text(
                    '${data.artist ?? 'No Artist'} - ${ImageUtils.getTimeStamp(data.duration ?? 0)}',
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            )),
            Text(data.fileExtension),
          ],
        ),
      ),
      onTap: () => controller.play(index),
    );
  }
}
