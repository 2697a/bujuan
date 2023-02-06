// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../routes/app_pages.dart';
//
// class RootView extends GetView {
//   const RootView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return RouterOutlet.builder(
//       delegate: Get.nestedKey(null),
//       builder: (context) {
//         return Scaffold(
//       backgroundColor: Colors.transparent,
//           body: GetRouterOutlet(
//             initialRoute: Routes.home,
//             delegate: Get.nestedKey(null),
//             anchorRoute: '/',
//             filterPages: (afterAnchor) {
//               // print(afterAnchor);
//               // print('dddddddddddddddddd');
//               // print(afterAnchor.take(1));
//               return afterAnchor.take(1);
//             },
//           ),
//         );
//       },
//     );
//   }
// }
