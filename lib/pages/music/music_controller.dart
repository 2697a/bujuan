import 'package:bujuan/main.dart';
import 'package:get/get.dart';

class MusicController extends GetxController {
  var artists = [].obs;
  var albums = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getAllArtists() async {
    var list = await Get.find<FileService>().audioQuery.getArtists();
    artists
      ..clear()
      ..addAll(list);
    getAllAlbum();
    print("object");
  }

  getAllAlbum() async {
    var list = await Get.find<FileService>().audioQuery.getAlbums();
    albums..clear()..addAll(list);
  }
}
