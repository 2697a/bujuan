import 'package:bujuan/widget/preload_page_view.dart';
import 'package:get/get.dart';

class DonateController extends GetxController {
  PreloadPageController pageController;
  final List<String> list = [
    'assets/images/ali.jpg',
    'assets/images/wechat.jpg',
  ];
  final currIndex = 0.obs;

  @override
  void onInit() {
    pageController = PreloadPageController();
    super.onInit();
  }
}
