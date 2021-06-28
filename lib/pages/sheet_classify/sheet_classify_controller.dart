import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:we_slide/we_slide.dart';

class SheetClassifyController extends GetxController {
  List<String> selectData = [
    '华语',
    '欧美',
    '日语',
    '韩语',
    '粤语',
    '小语种',
    '流行',
    '摇滚',
    '民谣',
    '电子',
    '舞曲',
    '80后',
    '90后',
    '00后',
    '怀旧',
    '治愈'
    // '18.古典',
    // '19.民族',
    // '20.英伦',
    // '21.金属',
    // '22.朋克',
    // '23.蓝调',
    // '24.雷鬼',
    // '25.世界音乐',
    // '26.拉丁',
    // '27.另类/独立',
    // '28.New Age',
    // '29.古风',
    // '30.后摇',
    // '31.Bossa Nova',
    // '32.清晨',
    // '33夜晚',
    // '34.学习',
    // '35.工作',
    // '36.午休',
    // '37.下午茶',
    // '38.地铁',
    // '39.驾车',
    // '40.运动',
    // '41.旅行',
    // '42.散步',
    // '43.酒吧',
    // '44.怀旧',
    // '45.清新',
    // '46.浪漫',
    // '47.性感',
    // '48.伤感',
    // '49.治愈',
    // '50.放松',
    // '51.孤独',
    // '52.感动',
    // '53.兴奋',
    // '54.快乐',
    // '55.安静',
    // '56.思念',
    // '57.影视原声',
    // '58.ACG',
    // '59.儿童',
    // '60.校园',
    // '61.游戏',
    // '62.70后',
    // '63.80后',
    // '64.90后',
    // '65.网络歌曲',
    // '66.KTV',
    // '67.经典',
    // '68.翻唱',
    // '69.吉他',
    // '70.钢琴',
    // '71.器乐',
    // '72.榜单',
    // '73.00后'
  ];
  RefreshController refreshController;
  var loadPageIndex = 0.obs;
  var classifySelect = '华语'.obs;
  var classifyData = [].obs;
  var enableLoadMore = true.obs;
  WeSlideController weSlideController;

  @override
  void onInit() {
    refreshController = RefreshController();
    weSlideController = WeSlideController();
    super.onInit();
  }

  @override
  void onReady() {
    getSheetData(classifySelect.value);
    weSlideController.addListener(() {
      if (weSlideController.isOpened) {
        Get.find<HomeController>().resumeStream();
      } else {
        Get.find<HomeController>().pauseStream();
      }
    });
    super.onReady();
  }

  ///获取数据
  getSheetData(classify) async {
    var sheetByClassify =
        await NetUtils().getSheetByClassify(classify, loadPageIndex * 15);
    if (sheetByClassify != null && sheetByClassify.code == 200) {
      if (loadPageIndex.value == 0) {
        classifyData
          ..clear()
          ..addAll(sheetByClassify.playlists);
        refreshController.refreshCompleted();
        if (sheetByClassify.playlists.length < 15) enableLoadMore.value = false;
      } else {
        if (sheetByClassify.more) {
          classifyData.addAll(sheetByClassify.playlists);
          refreshController?.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }
    }
  }

  ///切换分类
  changeOrRefreshClassify(classify) {
    classifySelect.value = classify;
    classifyData.clear();
    loadPageIndex.value = 0;
    getSheetData(classify);
  }

  ///刷新数据
  loadMoreData() {
    loadPageIndex.value++;
    getSheetData(classifySelect.value);
  }

  @override
  void onClose() {
    weSlideController = null;
    super.onClose();
  }
}
