import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopArtistsController extends GetxController {
  RefreshController refreshController;
  int currPage = 0;
  final artists = [].obs;

  @override
  void onInit() {
    refreshController = RefreshController();
    getData(true);
    super.onInit();
  }

  //获取数据
  getData(bool refresh) {
    NetUtils().getTopArtists(currPage * 15).then((data) {
      if (!GetUtils.isNullOrBlank(data) && data.code == 200) {
        if(refresh){
          artists..clear()..addAll(data.artists);
        }else{
          if(data.more) {
            artists.addAll(data.artists);
          }else{
            refreshController.resetNoData();
          }
        }
      }
    });
  }
}
