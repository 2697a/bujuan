import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:example/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  final List<MenuClass> mainMenu;
  final void Function(int)? callback;
  final int? current;

  const MenuScreen(
    this.mainMenu, {
    this.callback,
    this.current,
  });

  @override
  Widget build(BuildContext context) {
    const _androidStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    const _iosStyle = TextStyle(color: Colors.white);
    final style = kIsWeb
        ? _androidStyle
        : Platform.isAndroid
            ? _androidStyle
            : _iosStyle;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Colors.indigo,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24.0,
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 36.0,
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Text(
                    tr("name"),
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Selector<MenuProvider, int>(
                  selector: (_, provider) => provider.currentPage,
                  builder: (_, index, __) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...mainMenu
                          .map(
                            (item) => MenuItemWidget(
                          key: Key(item.index.toString()),
                          item: item,
                          callback: callback,
                          widthBox: const SizedBox(width: 16.0),
                          style: style,
                          selected: index == item.index,
                        ),
                      )
                          .toList()
                    ],
                  ),
                ),
                // Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      final languageCode =
                      (context.locale.languageCode == "ar") ? "en" : "ar";

                      context.setLocale(Locale(languageCode));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tr("logout"),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final MenuClass? item;
  final Widget? widthBox;
  final TextStyle? style;
  final void Function(int)? callback;
  final bool? selected;

  const MenuItemWidget({
    Key? key,
    this.item,
    this.widthBox,
    this.style,
    this.callback,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => callback!(item!.index),
      style: TextButton.styleFrom(
        primary: selected! ? const Color(0x44000000) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            item!.icon,
            color: Colors.white,
            size: 24,
          ),
          widthBox!,
          Expanded(
            child: Text(
              item!.title,
              style: style,
            ),
          )
        ],
      ),
    );
  }
}

class MenuClass {
  final String title;
  final IconData icon;
  final int index;

  const MenuClass(this.title, this.icon, this.index);
}
