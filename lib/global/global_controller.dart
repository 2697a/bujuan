import 'package:get/get.dart';

class GlobalController extends GetxController{
  var song = "暂未播放".obs;


  @override
  void onInit() {
    super.onInit();
  }

  void add(songName){
    song.value = songName;
  }
}