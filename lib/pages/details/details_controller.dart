import 'package:bujuan/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../common/bean/song_details_entity.dart';

class DetailsController extends GetxController {
  DetailsArguments? detailsArguments;
  bool added = false;

  @override
  void onInit() {
    detailsArguments = Get.arguments;
    super.onInit();
  }

  void initSong(List<SongDetailsSongs> songs) {}

  void playByIndex(int index) async {}
}
