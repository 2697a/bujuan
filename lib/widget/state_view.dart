import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum LoadState { SUCCESS, FAIL, EMPTY, IDEA }

class StateView extends GetView {
  final LoadState loadState;
  final Widget widget;

  StateView(this.loadState, this.widget);

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (loadState) {
      case LoadState.IDEA:
      case LoadState.SUCCESS:
        return widget;
        break;
      case LoadState.FAIL:
        return Center(
          child: Text('加载错误'),
        );
        break;
      case LoadState.EMPTY:
        return Center(
          child: Text('暂无数据'),
        );
        break;
    }
  }
}
