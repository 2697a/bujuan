// // 导入必要的库
// import 'dart:ui' as ui;
// import 'package:flutter/rendering.dart' as rendering;
// import 'package:flutter/widgets.dart';
// import 'package:image/image.dart' as img;
//
// // 定义一个渲染器，用于将图片转换为像素风格
// class PixelateRenderer extends rendering.CustomPainter {
//   PixelateRenderer(this.image, this.pixelSize);
//
//   final img.Image image;
//   final double pixelSize;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Rect rect = Offset.zero & size;
//     ui.PictureRecorder recorder = ui.PictureRecorder();
//     Canvas imageCanvas = Canvas(recorder);
//     Paint paint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = const Color(0xFF000000);
//
//     for (int x = 0; x < image.width; x += pixelSize.toInt()) {
//       for (int y = 0; y < image.height; y += pixelSize.toInt()) {
//         int color = image.getPixel(x, y);
//         print('===============$color');
//         Color c = Color(_getColorFromInt(color));
//         paint.color = c;
//         Rect pixelRect = Rect.fromLTWH(x.toDouble(), y.toDouble(), pixelSize, pixelSize);
//         imageCanvas.drawRect(pixelRect, paint);
//       }
//     }
//     canvas.scale(rect.width / image.width, rect.height / image.height);
//     canvas.drawPicture(recorder.endRecording());
//   }
//
//   @override
//   bool shouldRepaint(PixelateRenderer oldDelegate) {
//     return oldDelegate.image != image || oldDelegate.pixelSize != pixelSize;
//   }
// }
//
// // 获取int类型的颜色信息
// int _getColorFromInt(int color) {
//   return ((color & 0xff000000) |
//   ((color & 0xff0000) >> 16) |
//   (color & 0xff00) |
//   ((color & 0xff) << 16)) &
//   0xffffffff;
// }
//
// // 使用PixelateRenderer
// Widget buildPixelatedImage(img.Image image, double pixelSize) {
//   return CustomPaint(
//     painter: PixelateRenderer(image, pixelSize),
//   );
// }
