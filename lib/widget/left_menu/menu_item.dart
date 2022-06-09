import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemView extends StatefulWidget {
  final bool isCollapsed;
  final bool isCollapsedAfterSec;
  final MenuItemData menuItem;

  const MenuItemView({
    this.isCollapsed = false,
    required this.menuItem,
    Key? key,
    required this.isCollapsedAfterSec,
  }) : super(key: key);

  @override
  MenuItemViewState createState() => MenuItemViewState();
}

class MenuItemViewState extends State<MenuItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.menuItem.select && !widget.isCollapsed ? Colors.lightBlue.withOpacity(.05) : Colors.transparent,
          border: Border(right: BorderSide(color: widget.menuItem.select && !widget.isCollapsed ? Colors.lightBlue : Colors.transparent, width: 2.w))),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: widget.isCollapsedAfterSec ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(
                widget.menuItem.icon,
                size: 42.w,
                color: widget.menuItem.select ? Colors.lightBlue.withOpacity(.6) : Colors.black.withOpacity(.6),
              ),
              Visibility(
                visible: !widget.isCollapsedAfterSec,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      !widget.isCollapsedAfterSec ? widget.menuItem.title : '',
                      style: TextStyle(color: widget.menuItem.select ? Colors.lightBlue.withOpacity(.6) : Colors.black.withOpacity(.6), fontSize: 28.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuItemData {
  String title;
  IconData icon;
  bool select;
  VoidCallback? onTap;


  MenuItemData(this.title, this.icon, {this.onTap, this.select = false});
}
