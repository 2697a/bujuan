import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomBarController extends GetxController {
  var isPlay = false.obs;
  var currentIndex = 0.obs;
  var song = SheetDetailsPlaylistTrack().obs;
  PanelController panelController;
  final mp3Url =
      "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3";
  final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();

  @override
  void onInit() {
    super.onInit();
    final Playlist playlist = Playlist(audios: [
      Audio.network(
        mp3Url,
        metas: Metas(title: 'hello world'),
      ),
      Audio.network(
        mp3Url,
        metas: Metas(title: 'hello world 2',artist: "lalal",image: MetasImage.network("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Ffront%2F342%2Fw700h442%2F20190321%2FxqrY-huqrnan7527352.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,"
            "10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1617447095&t=49ad10b2c81c151cfa993b98ace7f6f1")),
      ),
    ]);
    // _player.open(
    //   playlist,
    //   autoStart: true,
    //   showNotification: true,
    // );
    _player.onReadyToPlay.listen((event) {
      print("object");
    });
  }
  void changeIndex(int index) {
    currentIndex.value = index;
    Get.find<HomeController>().changeIndex(index);
  }
  changeSong(SheetDetailsPlaylistTrack song) {
    this.song.value = song;
    isPlay.value = true;
    _player.playOrPause();
    // panelController?.open();
  }

  setPanelController(PanelController panelController){
    this.panelController = panelController;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
