import 'package:flutter/material.dart';

class SidebarContent extends StatelessWidget {
  const SidebarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'This sidebar serves as a demonstration of the TransparentMacOSSidebar '
        'widget.\n\nCheck out the transparent_sidebar_and_content.dart file to '
        'see how it has been implemented!',
      ),
    );
  }
}
