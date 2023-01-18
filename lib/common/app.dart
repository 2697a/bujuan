// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// /// APP全局Bloc类
// class AppGlobalBloc extends Bloc<_AppGlobalEvent, AppGlobalState> {
//   AppGlobalBloc(super.initialState) {
//     // 下面在注册相应的事件，并在事件接收后变更状态
//     on<_AppGlobalChangeThemeColorEvent>(
//             (event, emit) => emit(state.copyWith(themeColor: event.themeColor)));
//     on<_AppGlobalChangeUserNameEvent>(
//             (event, emit) => emit(state.copyWith(userName: event.userName)));
//   }
//
//   /// 变更主题色，就是添加一个变更主题色的事件
//   void changeThemeColor(MaterialColor themeColor) =>
//       add(_AppGlobalChangeThemeColorEvent(themeColor: themeColor));
//
//   /// 变更用户名，就是添加一个变更用户名的事件
//   void changeUserName(String? userName) =>
//       add(_AppGlobalChangeUserNameEvent(userName: userName));
// }
//
// /// 全局状态类
// class AppGlobalState {
//   AppGlobalState({
//     this.themeColor = Colors.indigo,
//     this.userName = "酱酱紫",
//   });
//
//   /// 主题色
//   MaterialColor themeColor;
//
//   /// 用户名称
//   String userName;
//
//   AppGlobalState copyWith({MaterialColor? themeColor, String? userName}) =>
//       AppGlobalState()
//         ..themeColor = themeColor ?? this.themeColor
//         ..userName = userName ?? this.userName;
//
//   static const List<MaterialColor> themeColors = Colors.primaries;
// }
//
// abstract class _AppGlobalEvent {}
//
// class _AppGlobalChangeThemeColorEvent extends _AppGlobalEvent {
//   _AppGlobalChangeThemeColorEvent({this.themeColor});
//
//   MaterialColor? themeColor;
// }
//
// class _AppGlobalChangeUserNameEvent extends _AppGlobalEvent {
//   _AppGlobalChangeUserNameEvent({this.userName});
//
//   String? userName;
// }