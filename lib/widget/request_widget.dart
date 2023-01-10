// import 'package:bujuan/widget/refresh_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
//
// import '../common/netease_api/src/netease_api.dart';
//
// typedef RequestChildBuilder<T> = Widget Function(T data);
//
// class RequestBox<T> extends StatefulWidget {
//   final RequestChildBuilder<T> childBuilder;
//   final Error? onError;
//   final ApiType url;
//   final Map? data; //FormData示例：FormData.from({'start': '0', 'count': '10'})
//   final bool wantKeepAlive;
//   final bool showError;
//   final String? baseUrl;
//   final Widget? replacement;
//   final RequestRefreshController? controller;
//
//   const RequestBox(
//       {Key? key,
//       required this.url,
//       required this.childBuilder,
//       this.controller,
//       this.data,
//       this.onError,
//       this.wantKeepAlive = false,
//       this.baseUrl,
//       this.replacement,
//       this.showError = false})
//       : super(key: key);
//
//   @override
//   RequestBoxState createState() {
//     return RequestBoxState<T>();
//   }
// }
//
// class RequestBoxState<T> extends State<RequestBox<T>> with RefreshState {
//   late T _entity;
//    bool _isLoaded = false;
//   final bool _isError = false;
//   NeteaseMusicApi neteaseMusicApi = GetIt.instance<NeteaseMusicApi>();
//
//   @override
//   void initState() {
//     super.initState();
//     _bindController();
//   }
//
//   // 绑定Controller
//   void _bindController() {
//     widget.controller?.bindEasyRefreshState(this);
//   }
//
//   @override
//   void dispose() {
//     widget.controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_isError) {
//       return const SizedBox.shrink();
//     }
//     return _isLoaded
//         ? widget.childBuilder(_entity)
//         : widget.replacement ??
//             const Center(
//               child: Text('加载中'),
//             );
//   }
//
//   @override
//   callRefresh() async{
//     try {
//       switch (widget.url) {
//         case ApiType.userPlayList:
//           _entity = (await neteaseMusicApi.userPlayList(widget.data!['id'])) as T;
//           break;
//       }
//     } catch (error) {
//       print('object');
//     }
//   }
//
//   @override
//   setParams(Map<String, dynamic> params) {
//     widget.data?.addEntries(params.entries);
//   }
// }
//
// enum ApiType { userPlayList }
