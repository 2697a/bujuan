import 'package:bujuan/common/constants/other.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../pages/home/home_controller.dart';

class PlayMoreInfo extends StatelessWidget {
  const PlayMoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(TablerIcons.alarm,color: Colors.white,),
            title: const Text('睡眠定时器',style: TextStyle(color: Colors.white),),
            onTap: () {
              Navigator.of(context).pop();
              Home.to.sleep(context);
            },
          ),
           ListTile(
            leading: const Icon(TablerIcons.share,color: Colors.white,),
            title: const Text('分享',style: TextStyle(color: Colors.white),),
            onTap: () {
              WidgetUtil.showToast('分享暂未开启');
            },
          )
        ],
      ),
    );
  }
}
