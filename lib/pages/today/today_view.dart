import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/pages/music_bottom_bar/music_bottom_bar_view.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/pages/play_view/default_view.dart';
import 'package:bujuan/pages/today/today_controller.dart';
import 'package:bujuan/utils/bujuan_util.dart';
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
      body: WeSlide(
        backgroundColor: Theme.of(Get.context).primaryColor,
        controller: controller.weSlideController,
        panelMaxSize: MediaQuery.of(Get.context).size.height,
        panelMinSize: 62.0,
        body: ScrollConfiguration(behavior: OverScrollBehavior(), child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              floating: true,
              pinned: true,
              title: Text('Today'),
              expandedHeight: 170.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Column(
                  children: [
                    Expanded(child: Container()),
                    Hero(
                        tag: 'today',
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                height: 120.0,
                                child: Image.asset('assets/images/today.png'),
                              ),
                              Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 120,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '每日推荐',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                        height: 120,
                                        alignment: Alignment.bottomRight,
                                        width: double.infinity,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              BuJuanUtil.dateToString(DateTime.now(),2),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0,color: Theme.of(Get.context).accentColor),
                                            ),
                                            Text(
                                              BuJuanUtil.dateToString(DateTime.now(),1),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,color: Theme.of(Get.context).accentColor),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
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
    );
  }

  Widget _buildTodayListView() {
    return Obx(()=>SliverFixedExtentList(
      itemExtent: 60.0,
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return controller.list.length>0?InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    height: 50.0,
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 40, minHeight: 30.0),
                    child: Text(
                      '${index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0,color: Colors.grey[500]),
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 25,
                            alignment: Alignment.centerLeft,
                            child: Text(controller.list[index].name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.centerLeft,
                            child: Text(controller.list[index].ar[0].name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14.0,color: Colors.grey[500])),
                          )
                        ],
                      )),
                  IconButton(icon: Icon(Icons.more_vert,color: Colors.grey[500],),onPressed: (){},)
                ],
              ),
            ),
            onTap: () => controller.playSong(index),
          ):LoadingView.buildGeneralLoadingView();
        },
        childCount: controller.list.length > 0
            ? controller.list.length
            : 20,
      ),
    ));
  }

}