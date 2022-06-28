import 'package:bujuan/pages/index/index_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../common/constants/other.dart';
import '../../widget/query_artwork_widget.dart' as custom;

class MainView extends GetView<IndexController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [ _buildTopSong()],
        ),
      ),
    );
  }

  Widget _buildTopCard() {
    return Container(
      height: 330.w,
      margin: EdgeInsets.only(top: 20.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.w), color: Theme.of(controller.buildContext).bottomAppBarColor),
      child: ListView.builder(itemBuilder: (context,index) => _buildAlbumItem(controller.albums[index]),itemCount: controller.albums.length,scrollDirection: Axis.horizontal,),
    );
  }

  Widget _buildAlbumItem(AlbumModel data){
    return Container(
      alignment: Alignment.center,
     margin: EdgeInsets.symmetric(horizontal: 20.w),
     child: custom.QueryArtworkWidget(
       id: data.id,
       type: ArtworkType.ALBUM,
       artworkBorder: BorderRadius.circular(5.w),
       artworkWidth: 260.w,
       artworkHeight: 260.w,
     ),
    );
  }

  Widget _buildTopSong() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.w), color: Theme.of(controller.buildContext).bottomAppBarColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text('Song',style: TextStyle(fontSize: 36.sp),),
              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios,size: 18,))
            ],
          ),
          ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) => _buildItem(controller.songs[index], index),
            itemCount: controller.songs.length>3?3:0,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  Widget _buildItem(SongModel data, int index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w),
        child: Row(
          children: [
            custom.QueryArtworkWidget(
              id: data.id,
              type: ArtworkType.AUDIO,
              artworkBorder: BorderRadius.circular(5.w),
              artworkWidth: 90.w,
              artworkHeight: 90.w,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(fontSize: 28.sp),
                  ),
                  Text(
                    '${data.artist ?? 'No Artist'} - ${ImageUtils.getTimeStamp(data.duration ?? 0)}',
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            )),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
      ),
      onTap: () => controller.play(index),
    );
  }
}
