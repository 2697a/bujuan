import 'package:bujuan/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends GetView {
  @override
  Widget build(BuildContext context) {
    return _buildNoLoginView();
  }

  Widget _buildNoLoginView() {
    return Center(
      child: IconButton(
        icon: Icon(Icons.supervised_user_circle_outlined),
        onPressed: () => Get.to(() => LoginView()),
      ),
    );
  }
}
