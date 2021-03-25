import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:we_slide/we_slide.dart';

class CloudController extends GetxController{
  WeSlideController weSlideController;
  RefreshController refreshController;
  var clouds = [].obs;
  var loadPageIndex = 0.obs;
  var enableLoadMore = true.obs;
  @override
  void onInit() {
    weSlideController = WeSlideController();
    refreshController = RefreshController();
    super.onInit();
  }
  @override
  void onReady() {
    _getCloudData();
    weSlideController.addListener(() {
      if (weSlideController.isOpened) {
        Get.find<HomeController>().resumeStream();
      } else {
        Get.find<HomeController>().pauseStream();
      }
    });
    super.onReady();
  }


  ///获云盘数据
  _getCloudData() async {
    var cloudEntity = await NetUtils().getCloudData(loadPageIndex*15);
    print('$cloudEntity');
    if (cloudEntity != null && cloudEntity.code == 200) {
      //获取成功
      if (loadPageIndex.value == 0) {
        // if(cloudEntity.data.length<15)enableLoadMore.value = false;
        clouds..clear()..addAll(cloudEntity.data);
        refreshController.refreshCompleted();
        if(cloudEntity.data.length<15)enableLoadMore.value = false;
      } else {
        if(cloudEntity.data.length>0){
          clouds.addAll(cloudEntity.data);
          refreshController?.loadComplete();
        }else{
          refreshController.loadNoData();
        }
      }
    }
  }

  refreshData() {
    loadPageIndex.value = 0;
    onReady();
  }

  loadMoreData() {
    loadPageIndex.value++;
    onReady();
  }
  @override
  void onClose() {
    // refreshController?.dispose();
    super.onClose();
  }
}