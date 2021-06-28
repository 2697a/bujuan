import 'package:bujuan/pages/top_artists/top_artists_controller.dart';
import 'package:get/get.dart';

class TopArtistsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TopArtistsController());
  }
}
