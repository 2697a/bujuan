import 'package:bujuan/pages/home/view/home_view.dart';
import 'package:bujuan/pages/home/view/z_comment_view.dart';
import 'package:bujuan/pages/home/view/z_lyric_view.dart';
import 'package:bujuan/pages/home/view/z_recommend_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:mobx/mobx.dart';

import '../../routes/router.dart';
import '../play_list/playlist_view.dart';

part 'home.g.dart';

// ignore: library_private_types_in_public_api
class Home = _Home with _$Home;

abstract class _Home with Store {
  double panelHeaderSize = 100.w;
  double panelMobileMinSize = 100.w;
  final List<LeftMenu> leftMenus = [
    LeftMenu('个人中心', TablerIcons.user, Routes.user, '/home/user'),
    LeftMenu('推荐歌单', TablerIcons.smart_home, Routes.index, '/home/index'),
    LeftMenu('本地歌曲', TablerIcons.file_music, Routes.local, '/home/local'),
    // LeftMenu('个性设置', TablerIcons.settings, Routes.setting, '/setting'),
  ];

  List<Widget> pages = [
    const RecommendView(),
    const PlayListView(),
    const LyricView(),
    const CommentView(),
  ];


  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}