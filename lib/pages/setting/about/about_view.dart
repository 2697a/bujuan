import 'package:bujuan/pages/setting/about/about_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Text(
              '不倦App(三方播放器)',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15.0),
            alignment: Alignment.center,
            child: Text(
              '不将本程序以及与之相关的网络服务用作非法用途以及非正当用途。 本程序内容仅代表作者本人的观点，不代表本程序的观点和看法，与本程序立场无关，相关责任作者自负。 使用本程序所带来的责任，由使用者承担。 本程序有部分内容来自互联网，如无意中侵犯了哪个媒体、公司、企业或个人等的知识产权，请来电或致函告之，本程序将在规定时间内给予删除等相关处理。',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }
}
