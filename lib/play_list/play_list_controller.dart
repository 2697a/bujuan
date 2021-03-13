import 'package:bujuan/global/global_controller.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class PlayListController extends GetxController{
  var playList = List<MusicItem>().obs;
  @override
  void onReady() {
    _getPlayList();
    super.onReady();
  }

  _getPlayList()async{
   var list = await Starry.getPlayList();
   playList.addAll(list);
  }

  playMusicByIndex(index){
    Starry.playMusicByIndex(index);
  }
}