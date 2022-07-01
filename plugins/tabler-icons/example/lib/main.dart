import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabler Icons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabler Icons"),
      ),
      body: SingleChildScrollView(
        child: Wrap(
            children: TablerIcons.iconList
                .map((eachIcon) => Icon(eachIcon.icon))
                .toList()),
      ),
    );
  }
}
