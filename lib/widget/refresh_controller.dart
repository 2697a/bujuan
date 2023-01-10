// /// RequestRefresh控制器
// class RequestRefreshController {
//   /// 更新入参并刷新
//   void callRefreshWithParams(Map<String, dynamic> params){
//     _requestBoxState?.setParams(params);
//     _requestBoxState?.callRefresh();
//   }
//
//   /// 触发刷新
//   void callRefresh() {
//     _requestBoxState?.callRefresh();
//   }
//
//   // 状态
//   RefreshState? _requestBoxState;
//
//   // 绑定状态
//   void bindEasyRefreshState(RefreshState state) {
//     _requestBoxState = state;
//   }
//
//   void dispose() {
//     _requestBoxState = null;
//   }
// }
//
// mixin RefreshState {
//   initState() {
//     callRefresh();
//   }
//
//   setParams(Map<String, dynamic> params);
//
//   callRefresh();
// }