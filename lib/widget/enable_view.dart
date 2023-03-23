import 'package:flutter/material.dart';

class EnableView extends StatelessWidget {
  const EnableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: const Dialog(
      backgroundColor: Colors.transparent,
      child: Center(child: Text('由于不可抗力因素\n本软件停止使用\n敬请谅解',style: TextStyle(fontSize: 26,height: 2,color: Colors.white),textAlign: TextAlign.center,),),
    ), onWillPop: () async {
      return false;
    });
  }
}
