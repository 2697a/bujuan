import 'package:bujuan/global/global_error_view.dart';
import 'package:bujuan/global/global_loding_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateView extends GetView {
  final int state;
  final Widget widget;

  StateView(this.state, {@required this.widget});

  @override
  Widget build(BuildContext context) {
    return state == 0
        ? LoadingView()
        : state == 1
            ? ErrorView()
            : widget;
  }
}
