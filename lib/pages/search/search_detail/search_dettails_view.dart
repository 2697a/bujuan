import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/pages/search/search_detail/search_detail_controller.dart';
import 'package:bujuan/widget/bottom_bar/navigation_bar.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDetailsView extends GetView<SearchDetailController> {
  @override
  Widget build(BuildContext context) {
    return PlayWidgetView(
      Padding(
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
      appBar: AppBar(
        title: Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
            Icon( const IconData(0xe61b, fontFamily: 'iconfont')),
            Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
            Expanded(
                child: TextField(
                  controller: controller.textEditingController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    controller.searchContext.value = value;
                    controller.onPageChange(0);
                    controller
                    .pageController.jumpToPage(0);
                  },
                  // inputFormatters: [FilteringTextInputFormatter(RegExp('[a-zA-Z]|[0-9.]'), allow: true)],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '搜索',
                  ),
                ))
          ],
        ),
      ),
      bottomBar: Obx(() => TitledBottomNavigationBar(
              enableShadow: false,
              currentIndex: controller.currIndex.value,
              // Use this to update the Bar giving a position
              onTap: (index) {
                controller.pageController?.jumpToPage(index);
              },
              items: [
                TitledNavigationBarItem(
                    title: Text('单曲'),
                    icon: Icons.music_note,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('歌单'),
                    icon: Icons.format_list_numbered_rounded,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('专辑'),
                    icon: Icons.album,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('歌手'),
                    icon: Icons.people,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('Mv'),
                    icon: Icons.video_collection,
                    backgroundColor: Theme.of(Get.context).primaryColor),
              ])),
    );
  }
}
