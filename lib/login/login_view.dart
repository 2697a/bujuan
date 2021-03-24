import 'package:bujuan/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text('登录'),
      ),
      body: Obx(() => ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
              ),
              Center(
                child: Image.asset('assets/images/logo.png',height: 106.0,width: 106.0,),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                child: Container(
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
                      Icon(Icons.account_circle),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                      Expanded(
                          child: TextField(
                            controller: controller.accountController,
                            // inputFormatters: [FilteringTextInputFormatter(RegExp('[a-zA-Z]|[0-9.]'), allow: true)],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '手机号或者邮箱',
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                child: Container(
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
                      Icon(Icons.verified),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                      Expanded(
                          child: TextField(
                            obscureText: true,
                            controller: controller.passController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '密码',
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                child: ProgressButton.icon(iconedButtons: {
                  ButtonState.idle: IconedButton(text: 'Login', icon: Icon(Icons.send, color: Colors.white), color: Theme.of(context).accentColor),
                  ButtonState.loading: IconedButton(text: 'Loading', color: Theme.of(context).accentColor),
                  ButtonState.fail: IconedButton(text: 'Failed', icon: Icon(Icons.cancel, color: Colors.white), color: Colors.red.shade300),
                  ButtonState.success: IconedButton(
                      text: 'Success',
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      color: Colors.green.shade400)
                }, onPressed: () => controller.login(), state: controller.state.value,height: 48.0),
              )
            ],
          )),
    );
  }
}
