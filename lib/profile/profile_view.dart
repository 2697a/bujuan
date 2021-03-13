import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            floating: true,
            pinned: true,
            expandedHeight: 220.0,
          ),
        ],
      ),
    );
  }

}