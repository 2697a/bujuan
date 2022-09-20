import 'package:bujuan/common/bean/personalized_entity.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:bujuan/widget/request_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../common/constants/other.dart';
import '../../widget/query_artwork_widget.dart' as custom;
import '../../widget/simple_extended_image.dart';
import '../home/home_controller.dart';

class MainView extends GetView<IndexController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: HomeController.to.getHomeBottomPadding(),top: 40.w),
        child: Column(
          children: [
            RequestBox<PersonalizedEntity>(
              url: '/personalized',
              childBuilder: (data) => CarouselSlider.builder(
                itemCount: (data.result ?? []).length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: SimpleExtendedImage(
                      (data.result ?? [])[itemIndex].picUrl ?? '',
                      borderRadius: BorderRadius.circular(30.w),
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () => Get.toNamed(Routes.playlist,arguments: (data.result ?? [])[itemIndex].id),
                ),
                options: CarouselOptions(
                  height: 450.w,
                  aspectRatio: 1,
                  viewportFraction: 0.6,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 40.w)),
            const Text('I am your uncle',style: TextStyle(fontSize: 42,color: Colors.red),)
          ],
        ),
      ),
    );
  }

  Widget _buildTopCard() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildSongItem(controller.songs[index], index),
      itemCount: controller.songs.length > 10 ? 10 : controller.songs.length,
    );
  }

  Widget _buildSongItem(SongModel data, int index) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.w),
        padding: EdgeInsets.symmetric(vertical: 5.w),
        child: Row(
          children: [
            SimpleExtendedImage(
              '${HomeController.to.directoryPath}${data.albumId}',
              cacheWidth: 200,
              width: 90.w,
              height: 90.w,
              borderRadius: BorderRadius.circular(10.w),
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
          ],
        ),
      ),
      onTap: () => controller.play(index),
    );
  }

  Widget _buildTopSong() {
    return SizedBox(
      height: Get.width / 3,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildItem(controller.albums[index], index),
        itemCount: controller.albums.length,
      ),
    );
  }

  Widget _buildItem(AlbumModel albumModel, index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        child: SimpleExtendedImage(
          '${HomeController.to.directoryPath}${albumModel.id}',
          cacheWidth: 400,
          width: Get.width / 3,
          height: Get.width / 3,
          borderRadius: BorderRadius.all(Radius.circular(20.w)),
        ),
      ),
    );
  }
}
