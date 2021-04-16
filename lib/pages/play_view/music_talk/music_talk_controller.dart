import 'dart:async';

import 'package:bujuan/utils/net_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MusicTalkController extends GetxController {
  var musicTalks = [].obs;
  var loadPageIndex = 1.obs;
  TextEditingController talkEditingController;
  RefreshController refreshController;
  TalkInfo talkInfo = Get.arguments['talk_info'];

  // MusicItem musicItem = Get.arguments['music'];

  @override
  void onInit() {
    refreshController = RefreshController();
    talkEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(Duration(milliseconds: 500),()=>_getMusicTalk());
    super.onReady();
  }

  ///获取歌曲评论
  _getMusicTalk() async {
    var songTalkEntity =
        await NetUtils().getMusicTalk(talkInfo.id, talkInfo.type, loadPageIndex.value);
    if (songTalkEntity != null && songTalkEntity.code == 200) {
      //获取成功
      if (loadPageIndex.value == 1) {
        musicTalks
          ..clear()
          ..addAll(songTalkEntity.data.comments);
        refreshController.refreshCompleted();
      } else {
        if (songTalkEntity.data.comments.length > 0) {
          musicTalks.addAll(songTalkEntity.data.comments);
          refreshController?.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }
    }
  }

  refreshTalk() {
    loadPageIndex.value = 1;
    onReady();
  }

  loadMoreTalk() {
    loadPageIndex.value++;
    onReady();
  }
}

class TalkInfo {
  final int type;
  final String id;
  final String picUrl;
  final String title;

  TalkInfo(this.type, this.id, this.picUrl, this.title);
}
