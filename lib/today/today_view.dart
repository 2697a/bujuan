import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/music_bottom_bar/music_bottom_bar_view.dart';
import 'package:bujuan/play_view/default_view.dart';
import 'package:bujuan/sheet_info/sheet_loading_view.dart';
import 'package:bujuan/today/today_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';

class TodayView extends GetView<TodayController>{
  @override
  Widget build(BuildContext context) {
    return _buildTodayView();
  }
  Widget _buildTodayView() {
    return Scaffold(
      body: AnnotatedRegion(
        child: WeSlide(
          controller: controller.weSlideController,
          panelMaxSize: MediaQuery.of(Get.context).size.height,
          panelMinSize: 65.0,
          body: Obx(() => CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0.0,
                floating: true,
                pinned: true,
                title: Text("Today"),
                expandedHeight: 170.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Column(
                    children: [
                      Expanded(child: Container()),
                      Hero(tag: "today", child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadiusDirectional.circular(6.0)),
                        clipBehavior: Clip.antiAlias,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.0),
                              height: 120.0,
                              child: Image.asset("assets/images/today.png"),
                            ),
                            Expanded(child: Text("每日推荐",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),))
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              _buildTodayListView()
            ],
          )),
          parallax: true,
          panel: DefaultView(weSlideController: controller.weSlideController),
          panelHeader: MusicBottomBarView(weSlideController: controller.weSlideController),
        ),
        value: !Get.isDarkMode
            ? SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: lightTheme.primaryColor,
        )
            : SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: darkTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildTodayListView() {
    return SheetLoadingView(
      state: controller.loadState.value,
      widget: SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              leading: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(maxWidth: 35.0),
                child: Text(
                  "${index + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(controller.list[index].ar[0].name),
              title: Text(controller.list[index].name),
              onTap: () {
                controller.playSong(index);
              },
            );
          },
          childCount: controller.list == null
              ? 0
              : controller.list.length,
        ),
      ),
    );
  }
}