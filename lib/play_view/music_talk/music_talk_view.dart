import 'package:bujuan/entity/music_talk.dart';
import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/over_scroll.dart';
import 'package:bujuan/play_view/music_talk/music_talk_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MusicTalkView extends GetView<MusicTalkController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(6.0)),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: '${controller.musicItem.iconUri}',
                height: 30.0,
                width: 30.0,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
            Expanded(
                child: Text('${controller.musicItem.title}',
                    overflow: TextOverflow.ellipsis))
          ],
        ),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                  child: ScrollConfiguration(
                behavior: OverScrollBehavior(),
                child: SmartRefresher(
                  enablePullUp: true,
                  controller: controller.refreshController,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return controller.musicTalks.length > 0
                                ? _buildMusicTalkItem(
                                    controller.musicTalks[index])
                                : LoadingView.buildLoadingTalkView();
                          },
                          childCount: controller.musicTalks.length > 0
                              ? controller.musicTalks.length
                              : 10,
                        ),
                      ),
                    ],
                  ),
                  onRefresh: () => controller.refreshTalk(),
                  onLoading: () => controller.loadMoreTalk(),
                ),
              )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: controller.talkEditingController,

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 8.0),

                            border: InputBorder.none,
                            hintText: '插一嘴？',
                          ),
                        )),
                    IconButton(icon: Icon(Icons.send), onPressed: () {})
                  ],
                ),
              )
            ],
          )),
    );
  }

  ///评论item
  Widget _buildMusicTalkItem(Comments comments) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(30.0)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: '${comments.user.avatarUrl}',
                  height: 30.0,
                  width: 30.0,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
              Text(
                '${comments.user.nickname}'
              )
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 40.0, bottom: 5.0, top: 5.0),
            child: Text(
              '${comments.content}',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
          Offstage(
            offstage: comments.showFloorComment.replyCount == 0,
            child: InkWell(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 40.0, bottom: 5.0, top: 5.0),
                child: Wrap(
                  children: [
                    Text(
                      '${comments.showFloorComment.replyCount}条回复 >',
                      style: TextStyle(color: Colors.blue, fontSize: 13.0),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

}
