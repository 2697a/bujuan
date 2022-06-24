import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../widget/query_artwork_widget.dart' as custom;

class AlbumView extends GetView<IndexController> {
  const AlbumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Obx(() => _buildAlbumView());
  }

  Widget _buildAlbumView(){
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.w,
        childAspectRatio: .8,
      ),
      itemCount: controller.albums.length,
      itemBuilder: (BuildContext context, int index) => _buildItem(controller.albums[index]),
    );
  }

  Widget _buildItem(AlbumModel albumModel){
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom.QueryArtworkWidget(
            id: albumModel.id,
            type: ArtworkType.ALBUM,
            artworkBorder: BorderRadius.circular(15.w),
            artworkWidth: double.infinity,
            artworkHeight: Get.width/2.2,
          ),
          Text(albumModel.album,style: TextStyle(fontSize: 28.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
          Text(albumModel.artist??'',style: TextStyle(fontSize: 24.sp),),
        ],
      ),
      onTap:() => Get.toNamed(Routes.details,arguments: DetailsArguments(albumModel)),
    );
  }
}
