// import 'package:bujuan/pages/home/first/home_view.dart';
// import 'package:bujuan/pages/index/album_view.dart';
// import 'package:bujuan/pages/index/index_binding.dart';
// import 'package:bujuan/pages/index/main_view.dart';
// import 'package:bujuan/pages/play_list/bindings.dart';
// import 'package:bujuan/pages/play_list/playlist.dart';
// import 'package:bujuan/pages/user/user_binding.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../pages/home/home_binding.dart';
// import '../pages/login/bindings.dart';
// import '../pages/login/login.dart';
// import '../pages/root/root_view.dart';
// import '../pages/user/user_view.dart';
//
// part 'app_routes.dart';
//
// class AppPages {
//   AppPages._();
//
//   static const initial = Routes.home;
//
//   static final routes = [
//     GetPage(
//       transition: Transition.cupertino,
//       name: '/',
//       page: () => const RootView(),
//       participatesInRootNavigator: true,
//       preventDuplicates: true,
//       children: [
//         GetPage(
//           name: _Paths.login,
//           page: () => const LoginView(),
//           bindings: [LoginBindings()],
//         ),
//         GetPage(
//           transition: Transition.cupertino,
//           preventDuplicates: true,
//           participatesInRootNavigator: false,
//           name: _Paths.home,
//           page: () => const FirstView(),
//           bindings: [HomeBinding(), UserBinding(), IndexBinding(), PlayListBindings()],
//           children: [
//             GetPage(
//               name: _Paths.user,
//               transition: Transition.cupertino,
//               page: () => const UserView(),
//               showCupertinoParallax: true,
//               participatesInRootNavigator: false,
//               children: [
//                 GetPage(
//                   transition: Transition.cupertino,
//                   participatesInRootNavigator: false,
//                   middlewares: const [],
//                   name: _Paths.playlist,
//                   popGesture: true,
//                   page: () => const PlayList(),
//                   bindings: [],
//                 ),
//               ],
//               bindings: const [
//                 // UserBinding(),
//               ],
//             ),
//             GetPage(
//                 middlewares: const [],
//                 transition: Transition.cupertino,
//                 name: _Paths.sheet,
//                 page: () => const MainView(),
//                 showCupertinoParallax: true,
//                 participatesInRootNavigator: false,
//                 bindings: [IndexBinding()],
//                 children: [
//                   GetPage(
//                     participatesInRootNavigator: false,
//                     transition: Transition.cupertino,
//                     middlewares: const [],
//                     name: _Paths.playlist,
//                     popGesture: true,
//                     page: () => const PlayList(),
//                     bindings: [],
//                   ),
//                 ]),
//             GetPage(
//               transition: Transition.cupertino,
//               middlewares: const [],
//               name: _Paths.cloud,
//               page: () => const AlbumView(),
//               bindings: [IndexBinding()],
//             ),
//           ],
//         ),
//       ],
//     ),
//   ];
// }
