import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';

class SheetLoadingView extends GetView {
  final int state;
  final Widget widget;

  SheetLoadingView({Key key, @required this.state, @required this.widget});

  @override
  Widget build(BuildContext context) {
    return state == 0
        ? _buildLoadingView()
        : state == 1
            ? _buildLoadingView()
            : widget;
  }

  Widget _buildLoadingView() {
    return SliverAnimatedList(
      itemBuilder: (context, index, value) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 10.0),
          width: 100,
          child: PlaceholderLines(
            count: 2,
            maxWidth: 0.9,
            minWidth: 0.6,
            align: TextAlign.left,
            animate: true,
            color: Colors.grey[400],
          ),
        );
      },
      initialItemCount: 15,
    );
  }
}
