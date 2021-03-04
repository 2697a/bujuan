import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("加载失败"),
      ),
    );
  }
}
