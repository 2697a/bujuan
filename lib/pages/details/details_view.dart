import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsView extends GetView{
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Text('sadsadsadsadasdsadasd\ndsadsadasdsad'),
      ),
    );
  }

}