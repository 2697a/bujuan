import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({Key? key}) : super(key: key);

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int index = 0;

  @override
  initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Row(
          children: [
            _buildItem(),
            _buildItem(),
            _buildItem(),
            _buildItem(),
          ],
        )),
        Image.asset('assets/images/logo.png',width: 65.w,height: 65.w,)
      ],
    );
  }

  Widget _buildItem(){
    return Expanded(child: Container(
      width: 65.w,
      height: 65.w,
      decoration: const BoxDecoration(
        color: Colors.blue
      ),
      child: Icon(Icons.add_alarm),
    ));
  }
}
