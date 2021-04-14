import 'package:bujuan/pages/music/album/local_album_controller.dart';
import 'package:get/get.dart';

class LocalAlbumBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LocalAlbumController>(LocalAlbumController());
  }

}