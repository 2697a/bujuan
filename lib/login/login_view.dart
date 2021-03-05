import 'package:bujuan/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller.accountController,
          ),
          TextField(
            controller: controller.passController,
          ),
          FlatButton(onPressed: () => controller.login(), child: Text("登录"))
        ],
      ),
    );
  }
}
