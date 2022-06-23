import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DetailsController extends GetxController {
  DetailsArguments? detailsArguments;
  RxList<SongModel> songs = <SongModel>[].obs;

  @override
  void onInit() {
    detailsArguments = Get.arguments;
    super.onInit();
  }

  queryAudiosFrom() async {
    songs.value = await HomeController.to.audioQuery.queryAudiosFrom(AudiosFromType.ALBUM, 1);
  }
}
