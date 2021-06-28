import 'package:intl/intl.dart';

/// 格式化时间
String duTimeLineFormat(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);

  // 1天内
  if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  }
  // // 30天内
  // else if (difference.inDays < 30) {
  //   return "${difference.inDays} days ago";
  // }
  // MM-dd
  else if (difference.inDays < 365) {
    final dtFormat = new DateFormat('MM-dd');
    return dtFormat.format(dt);
  }
  // yyyy-MM-dd
  else {
    final dtFormat = new DateFormat('yyyy-MM-dd');
    var str = dtFormat.format(dt);
    return str;
  }
}
