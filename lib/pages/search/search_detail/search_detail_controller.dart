import 'package:bujuan/pages/search/search_airsit/search_airsit_controller.dart';
import 'package:bujuan/pages/search/search_airsit/search_airsit_view.dart';
import 'package:bujuan/pages/search/search_album/search_album_controller.dart';
import 'package:bujuan/pages/search/search_album/search_album_view.dart';
import 'package:bujuan/pages/search/search_mv/search_mv_controller.dart';
import 'package:bujuan/pages/search/search_mv/search_mv_view.dart';
import 'package:bujuan/pages/search/search_sheet/search_sheet_controller.dart';
import 'package:bujuan/pages/search/search_sheet/search_sheet_view.dart';
import 'package:bujuan/pages/search/search_song/search_song_controller.dart';
import 'package:bujuan/pages/search/search_song/search_song_view.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:get/get.dart';

class SearchDetailController extends GetxController {
   PreloadPageController pageController;
  final searchContext = ''.obs;
  final currIndex = 0.obs;
  final pages = [
    SearchSongView(),
    SearchSheetView(),
    SearchAlbumView(),
    SearchAirsittView(),
    SearchMvView(),
  ];

  static SearchDetailController get to => Get.find();

  @override
  void onInit() {
    pageController = PreloadPageController();
    searchContext.value = Get.arguments['content'];
    Get.put<SearchSongController>(SearchSongController());
    Get.put<SearchAirsitController>(SearchAirsitController());
    Get.put<SearchSheetController>(SearchSheetController());
    Get.put<SearchAlbumController>(SearchAlbumController());
    Get.put<SearchMvController>(SearchMvController());
    super.onInit();
  }

  onPageChange(index) {
    currIndex.value = index;
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }
}
