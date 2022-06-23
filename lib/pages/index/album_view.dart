import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
        childAspectRatio: .83,
      ),
      itemCount: controller.albums.length,
      itemBuilder: (BuildContext context, int index) => _buildItem(controller.albums[index]),
    );
  }

  Widget _buildItem(AlbumModel albumModel){
    return InkWell(
      child: Container(
        child: Column(
          children: [
            QueryArtworkWidget(
              id: albumModel.id,
              type: ArtworkType.ALBUM,
              artworkBorder: BorderRadius.circular(5.w),
              artworkWidth: double.infinity,
              artworkHeight: Get.width/2.2,
            ),
            Text(albumModel.album)
          ],
        ),
      ),
      onTap:() => Get.toNamed(Routes.details,arguments: DetailsArguments(albumModel)),
    );
  }
}
