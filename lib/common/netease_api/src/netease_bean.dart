export '../src/api/dj/bean.dart';
export '../src/api/event/bean.dart';
export '../src/api/login/bean.dart';
export '../src/api/play/bean.dart';
export '../src/api/search/bean.dart';
export '../src/api/uncategorized/bean.dart';
export '../src/api/user/bean.dart';

const int RET_CODE_UNKNOW = -233;
const int RET_CODE_OK = 200;
const int RET_CODE_NO_PERMISSION = -2;
const int RET_CODE_OK_FOLLOW = 201;
// title: "风险提示",subtitle: "请您尝试切换网络或设备再尝试操作哦~",buttonMsg: "查看详情",buttonUrl: "http://163.lu/EmUzy2"
const int RET_CODE_RISK_WARNING = 250;
const int RET_CODE_CHEATING = -460;
const int RET_CODE_NEED_LOGIN = 301;
const int RET_CODE_ILLEGAL = 400;
const int RET_CODE_ILLEGAL_REQUEST = 403;
const int RET_CODE_REQUEST_NOT_FOUNT = 404;
//用户已初始化
const int RET_CODE_HAS_INIT = 408;
const int RET_CODE_ACCOUNT_NOT_FOUND = 501;
const int RET_CODE_UPDATE_PROFILE_OCCUPY = 505;

const int RET_CODE_CAPTCHA_VERIFY_FAIL = 503;
const int RET_CODE_CAPTCHA_VERIFY_FREQUENTLY = 405;

//未付费歌曲无法收藏
const int RET_CODE_UNPAID = 512;

enum RetCode {
  Ok,
  NeedLogin,
  IllegalArgument,
  IllegalRequest,
  RequestNotFount,
  UnKnow
}

RetCode valueOfCode(int code) {
  switch (code) {
    case RET_CODE_OK:
      return RetCode.Ok;
    case RET_CODE_NEED_LOGIN:
      return RetCode.NeedLogin;
    case RET_CODE_ILLEGAL:
      return RetCode.IllegalArgument;
    case RET_CODE_ILLEGAL_REQUEST:
      return RetCode.IllegalRequest;
    case RET_CODE_REQUEST_NOT_FOUNT:
      return RetCode.RequestNotFount;
  }
  return RetCode.UnKnow;
}
