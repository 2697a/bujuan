import 'dart:async';

import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:starry/starry.dart';

class TimingController extends GetxController {
  var isStart = false.obs;
  var selectIndex = 99.obs;
  var data = [].obs;
  var time = 0.obs;
  StreamSubscription _streamSubscription;

  @override
  void onInit() {
    selectIndex.value = SpUtil.getInt("TIMING_INDEX", defValue: 99);
    data.addAll([
      TimingData("分钟", 10 * 60, "10"),
      TimingData("分钟", 20 * 60, "20"),
      TimingData("分钟", 30 * 60, "30"),
      TimingData("分钟", 45 * 60, "45"),
      TimingData("小时", 60 * 60, "1"),
      TimingData("小时", 1.5 * 60 * 60, "10"),
      TimingData("小时", 2 * 60 * 60, "2"),
      TimingData("小时", 2.5 * 60 * 60, "2.5"),
      TimingData("小时", 3 * 60 * 60, "3"),
      TimingData("小时", 4 * 60 * 60, "4")
    ]);
    super.onInit();
  }

  @override
  void onReady() {
    _streamSubscription = Starry.eventChannel.receiveBroadcastStream().listen((pos) {
      if (pos != null) {
        time.value = pos;
        print("object======$pos");
      }
    }, cancelOnError: true);
    super.onReady();
  }

  changeIndex(index) {
    selectIndex.value = index;
    Starry.startTiming(60000);
  }

  changeState(value) {
    isStart.value = value;
    if (!value) {
      selectIndex.value = 99;
    } else {
      if (selectIndex.value == 99) selectIndex.value = 4;
    }
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }
}

class TimingData {
  var format;
  var value;
  var name;

  TimingData(this.format, this.value, this.name);
}
