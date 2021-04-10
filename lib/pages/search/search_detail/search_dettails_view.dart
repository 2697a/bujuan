import 'package:bujuan/pages/search/search_detail/search_detail_controller.dart';
import 'package:bujuan/widget/bottom_bar/navigation_bar.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDetailsView extends GetView<SearchDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Obx(()=>Text('${controller.searchContext.value}')),),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: PreloadPageView.builder(
            controller: controller.pageController,
            itemBuilder: (context, index) {
              return controller.pages[index];
            },
            itemCount: controller.pages.length,
            onPageChanged: (index) {
              controller.onPageChange(index);
            },
          ),
        ),
        bottomNavigationBar: Obx(()=>TitledBottomNavigationBar(
            currentIndex: controller.currIndex.value, // Use this to update the Bar giving a position
            onTap: (index) {
              controller.pageController?.jumpToPage(index);
            },
            items: [
              TitledNavigationBarItem(title: Text('单曲'), icon: Icons.music_note,backgroundColor: Theme.of(Get.context).primaryColor),
              TitledNavigationBarItem(
                  title: Text('歌手'), icon: Icons.people,backgroundColor: Theme.of(Get.context).primaryColor),
              TitledNavigationBarItem(
                  title: Text('歌单'), icon: Icons.format_list_numbered_rounded,backgroundColor: Theme.of(Get.context).primaryColor),
              TitledNavigationBarItem(
                  title: Text('专辑'), icon: Icons.album,backgroundColor: Theme.of(Get.context).primaryColor),
              TitledNavigationBarItem(
                  title: Text('Mv'), icon: Icons.video_collection,backgroundColor: Theme.of(Get.context).primaryColor),
            ])));
  }
}
