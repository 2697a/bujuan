import 'package:bujuan/pages/album/album_controller.dart';
import 'package:get/get.dart';

class AlbumBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AlbumController>( AlbumController());
  }

}