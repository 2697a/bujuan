import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/pages/radio/radio_detail/radio_detail_controller.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/widget/state_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RadioDetailView extends GetView<RadioDetailController>{
  @override
  Widget build(BuildContext context) {
    return PlayWidgetView(_buildRadioDetailView(),appBar: AppBar(title: Text('${controller.djRadios.name}'),),);
  }


  Widget _buildRadioDetailView(){
    return Obx(()=>StateView(controller.loadState.value, ScrollConfiguration(behavior: OverScrollBehavior(), child: SmartRefresher(
      controller: controller.refreshController,
      enablePullUp: true,
      header:  WaterDropMaterialHeader(
        color: Theme.of(Get.context).accentColor,
        backgroundColor: Theme.of(Get.context).primaryColor,
      ),
      footer: ClassicFooter(),
      onRefresh: ()=>controller.getDjProgram(),
      onLoading: ()=>controller.getDjProgram(false),
      child: CustomScrollView(
        slivers: [
          SliverFixedExtentList(
            itemExtent: 60.0,
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return controller.program.length > 0
                    ? InkWell(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 2.0, top: 5.0,bottom: 5.0,right: 45.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          height: 50.0,
                          alignment: Alignment.center,
                          constraints:
                          BoxConstraints(maxWidth: 40, minHeight: 30.0),
                          child: Text(
                            '${index + 1}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey[500]),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 25,
                                  alignment: Alignment.centerLeft,
                                  child: Text(controller.program[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16.0)),
                                ),
                                Container(
                                  height: 25,
                                  alignment: Alignment.centerLeft,
                                  child: Text('${controller.program[index].listenerCount} play',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[500])),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  onTap: () =>controller.playSong(index),
                )
                    : LoadingView.buildGeneralLoadingView();
              },
              childCount:
              controller.program.length > 0 ? controller.program.length : 20,
            ),
          )
        ],
      ),
    ))));
  }
}