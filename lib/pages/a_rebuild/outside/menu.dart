import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 80.w)),
        TextButton(
            onPressed: () {
              ref.read(zoomController).toggle?.call();
              context.go('/');
            },
            child: Text('测试按钮1')),
        TextButton(
            onPressed: () {
              ref.read(zoomController).toggle?.call();
              context.go('/user');
            },
            child: Text('测试按钮1')),
      ],
    );
  }
}
