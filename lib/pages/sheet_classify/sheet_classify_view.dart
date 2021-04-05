import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/pages/music_bottom_bar/music_bottom_bar_view.dart';
import 'package:bujuan/pages/play_view/default_view.dart';
import 'package:bujuan/pages/sheet_classify/sheet_classify_controller.dart';
import 'package:bujuan/pages/sheet_info/head.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:we_slide/we_slide.dart';

import '../../widget/over_scroll.dart';

class SheetClassifyView extends GetView<SheetClassifyController> {
  @override
  Widget build(BuildContext context) {
    return _buildSheetClassifyView(context);
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }


  Widget _buildSheetClassifyView(context){
    return Scaffold(
      body: WeSlide(
        backgroundColor: Theme.of(Get.context).primaryColor,
        controller: controller.weSlideController,
        panelMaxSize: MediaQuery.of(Get.context).size.height,
        panelMinSize: 62.0,
        body: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('歌单分类'),
          ),
          body: DirectSelectContainer(
            child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: SmartRefresher(
                header:  WaterDropMaterialHeader(
                  color: Theme.of(context).accentColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                footer: ClassicFooter(),
                controller: controller.refreshController,
                enablePullUp: true,
                onRefresh: () => controller.changeOrRefreshClassify(controller.classifySelect.value),
                onLoading: () => controller.loadMoreData(),
                child: _buildContent(),
              ),
            ),
          ),
        ),
        parallax: true,
        panel: DefaultView(weSlideController: controller.weSlideController),
        panelHeader: MusicBottomBarView(weSlideController: controller.weSlideController),
      ),
    );
  }
  Widget _buildContent() {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: false,
            pinned: true,
            delegate: SliverAppBarDelegate(
                maxHeight: 58.0,
                minHeight: 58.0,
                child: Card(
                  child: Row(
                    children: [Expanded(child: Padding(
                        child: DirectSelectList<String>(
                            values: controller.selectData,
                            itemBuilder: (String value) => getDropDownMenuItem(value),
                            // focusedItemDecoration: _getDslDecoration(),
                            onItemSelectedListener: (item, index, context) {
                              controller.changeOrRefreshClassify(item);
                            }),
                        padding: EdgeInsets.only(left: 12))),Icon(Icons.keyboard_arrow_right_rounded)],
                  ),
                ))),
        Obx(() => SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return controller.classifyData.length > 0
                    ? InkWell(
                        child: Wrap(
                          children: [
                            Hero(
                              tag: '${controller.classifyData[index].id}',
                              child: Center(
                                child: Card(
                                  // margin: EdgeInsets.all(0),
                                  child: CachedNetworkImage(
                                    height: 110.0,
                                    width: 110.0,
                                    fit: BoxFit.fill,
                                    imageUrl: '${controller.classifyData[index].coverImgUrl}?param=250y250',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                              child: Text(controller.classifyData[index].name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                            )
                          ],
                        ),
                        onTap: () {
                          Get.toNamed('/sheet', arguments: {'id': controller.classifyData[index].id, 'name': controller.classifyData[index].name, 'imageUrl': '${controller.classifyData[index].coverImgUrl}?param=300y300'});
                        })
                    : LoadingView.buildGridViewSheetLoadingView();
              },
              childCount: controller.classifyData.length > 0 ? controller.classifyData.length : 20,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: .69,
            )))
      ],
    );
  }
}
