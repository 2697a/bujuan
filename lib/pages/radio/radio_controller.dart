import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/widget/state_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RadioController extends GetxController {
  RefreshController refreshController;

  final list = [].obs;
  int loadPage = 0;
  final loadState = LoadState.IDEA.obs;
  final openLoad = true.obs;

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    getUserDjSubList();
    super.onReady();
  }

  getUserDjSubList([isRefresh = true]) {
    NetUtils().userDjSublist(loadPage * 30).then((value) {
      if (value != null && value.code == 200) {
        if ((value.djRadios == null || value.djRadios.length == 0) &&
            isRefresh) {
          loadState.value = LoadState.EMPTY;
          return;
        }
        if (isRefresh) {
          list
            ..clear()
            ..addAll(value.djRadios);
          refreshController.refreshCompleted();
        } else {
          list.addAll(value.djRadios);
          loadPage++;
          refreshController.loadComplete();
        }
      } else {
        loadState.value = LoadState.FAIL;
      }

      if (!value.hasMore) {
        if(list.length<30){
          openLoad.value = false;
        }else{
          refreshController.loadNoData();
        }
      }
    });
  }
}
