import 'package:bujuan/entity/song_talk_entity.dart';
import 'package:bujuan/over_scroll.dart';
import 'package:bujuan/play_view/music_talk/music_talk_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicTalkView extends GetView<MusicTalkController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => ScrollConfiguration(behavior: OverScrollBehavior(), child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return controller.musicTalk.value!=null?_buildMusicTalkItem(controller.musicTalk.value.comments[index]):Text("data");
              },
              childCount: controller.musicTalk.value!=null? controller.musicTalk.value.comments.length : 10,
            ),
          ),
        ],
      ))),
    );
  }

  Widget _buildMusicTalkItem(SongTalkCommants songTalkCommants){
    return ListTile(
      title: Text("${songTalkCommants.showFloorComment}----${songTalkCommants.parentCommentId}"),
    );
  }
}
