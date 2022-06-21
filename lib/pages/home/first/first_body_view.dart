import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FirstBodyView extends GetView<HomeController>{
  final Widget widget;
  const FirstBodyView(this.widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widget;
  }

}