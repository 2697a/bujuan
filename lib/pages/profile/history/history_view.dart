import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/pages/profile/history/history_controller.dart';
import 'package:bujuan/widget/bottom_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return PlayWidgetView(Obx(() => ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return controller.history.length > 0
            ? InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 2.0, vertical: 5.0),
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
                          child: Text('${controller.history[index].song.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.0)),
                        ),
                        Container(
                          height: 25,
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '${controller.history[index].song.ar[0].name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[500])),
                        )
                      ],
                    )),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey[500],
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          onTap: () =>controller.playSong(index),
        )
            : LoadingView.buildGeneralLoadingView();
      },
      itemCount:
      controller.history.length > 0 ? controller.history.length : 15,
    )),appBar:  AppBar(title: Text('听歌记录')),bottomBar: TitledBottomNavigationBar(
        enableShadow: false,
        currentIndex: controller.currIndex.value,
        // Use this to update the Bar giving a position
        onTap: (index) {
          controller.changeIndex(index);
        },
        items: [
          TitledNavigationBarItem(
              title: Text('最近一周'),
              icon: Icons.view_week_rounded,
              backgroundColor: Theme.of(Get.context).primaryColor),
          TitledNavigationBarItem(
              title: Text('所有时间'),
              icon: Icons.all_inbox,
              backgroundColor: Theme.of(Get.context).primaryColor),
        ]));
  }
}
