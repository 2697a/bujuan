import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';

import '../pages/home/home_controller.dart';

class ShareView extends StatelessWidget {
  const ShareView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: SimpleExtendedImage(Home.to.mediaItem.value.extras?['image']),
      ),
    );
  }
}
