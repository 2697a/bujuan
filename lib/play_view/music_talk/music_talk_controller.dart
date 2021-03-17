import 'package:bujuan/entity/song_talk_entity.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';

class MusicTalkController extends GetxController{
  var musicTalk = SongTalkEntity().obs;
  @override
  void onInit() {
    musicTalk.value = null;
    super.onInit();
  }

  @override
  void onReady() {
    _getMusicTalk(Get.arguments["id"]);
    super.onReady();
  }

  ///获取歌曲评论
  _getMusicTalk(id) async{
    var songTalkEntity = await NetUtils().getMusicTalk(id, 0);
    if(songTalkEntity!=null&&songTalkEntity.code==200){
      //获取成功
      if(musicTalk.value==null){
        musicTalk.value = songTalkEntity;
      }else{
        musicTalk.value.hotComments.addAll(songTalkEntity.hotComments);
        musicTalk.value.comments.addAll(songTalkEntity.comments);
      }
    }
  }
}