
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MinNiNavBar extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomMiniNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;

  MinNiNavBar({
    Key key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onItemSelected,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onItemSelected != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: 25,
        padding:  EdgeInsets.symmetric(vertical: 9, horizontal: 10),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: items.map((item) {
            var index = items.indexOf(item);
            return GestureDetector(
              onTap: () => onItemSelected(index),
              child: _ItemWidget(
                item: item,
                iconSize: iconSize,
                isSelected: index == selectedIndex,
                backgroundColor: Colors.transparent,
                itemCornerRadius: itemCornerRadius,
                animationDuration: animationDuration,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(26);
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomMiniNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;

  const _ItemWidget(
      {Key key,
        @required this.item,
        @required this.isSelected,
        @required this.backgroundColor,
        @required this.animationDuration,
        @required this.itemCornerRadius,
        @required this.iconSize})
      : assert(isSelected != null),
        assert(item != null),
        assert(backgroundColor != null),
        assert(animationDuration != null),
        assert(itemCornerRadius != null),
        assert(iconSize != null),
        super(key: key);



  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isSelected ? 45: 15,
      height: double.maxFinite,
      duration: animationDuration,
      decoration: BoxDecoration(
        color: item.activeColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(itemCornerRadius),
      ),
    );
  }
}

class BottomMiniNavyBarItem {
  final Color activeColor;
  final Color inactiveColor;

  BottomMiniNavyBarItem({
    this.activeColor = Colors.blue,
    this.inactiveColor,
  });
}
