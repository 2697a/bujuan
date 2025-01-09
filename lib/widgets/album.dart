import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'image.dart';

abstract class Album {}

class AlbumImage extends StatelessWidget {
  const AlbumImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: ZigZagClipper(),
        child: Stack(
          children: [
            ImageView(url: "https://p2.music.126.net/ArbpVuafLfcdRAPDi4JTDA==/109951167896179360.jpg",width: 260,height: 260,isCircle: true,),
            // CustomPaint(
            //   size: ui.Size(340, 340),
            //   painter: AlbumCoverPainter(),
            // )
          ],
        ),
      ),
    );
  }
}

class AlbumCoverPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw main circular mask with a gradient for a slight faded effect
    Paint circlePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withOpacity(0.3),
          Colors.black.withOpacity(0.1),
          Colors.transparent,
        ],
        stops: const [0.6, 0.8, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, circlePaint);

    // Draw border around the hole
    // Paint holeBorderPaint1 = Paint()
    //   ..color = Colors.black.withOpacity(.2)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2.0 ; // Adjust this for desired border thickness
    // canvas.drawCircle(center, radius , holeBorderPaint1);
    // Adding texture to create a worn effect
    Paint texturePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    Random random = Random();
    // Draw random lines to simulate scratches
    for (int i = 0; i < 100; i++) {
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;
      final endX = startX + (random.nextDouble() * 20 - 10);
      final endY = startY + (random.nextDouble() * 20 - 10);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), texturePaint);
    }

    // Draw circles for "vintage spots" to add some wear
    for (int i = 0; i < 50; i++) {
      final spotX = random.nextDouble() * size.width;
      final spotY = random.nextDouble() * size.height;
      final spotRadius = random.nextDouble() * 3;
      canvas.drawCircle(Offset(spotX, spotY), spotRadius, texturePaint);
    }

    // Draw the inner hole
    // Paint holePaint = Paint()..color = Colors.white;
    // canvas.drawCircle(center, radius * 0.09, holePaint);
    // // Draw border around the hole
    // Paint holeBorderPaint = Paint()
    //   ..color = Colors.black.withOpacity(.2)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2.0; // Adjust this for desired border thickness
    // canvas.drawCircle(center, radius * 0.09, holeBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TornPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final imageRect = Rect.fromLTWH(0, 0, size.width, size.height);
    //
    // // 创建四边撕裂路径
    // Path tornEdgePath = Path();
    // Random random = Random();
    //
    // // Top edge
    // double x = 0;
    // tornEdgePath.moveTo(x, 0);
    // while (x < size.width) {
    //   double yOffset = random.nextDouble() * 15 - 5;
    //   x += random.nextDouble() * 20;
    //   if (x < size.width) {
    //     tornEdgePath.lineTo(x, yOffset);
    //   }
    // }
    //
    // // Right edge
    // double y = 0;
    // tornEdgePath.lineTo(size.width, y);
    // while (y < size.height) {
    //   double xOffset = random.nextDouble() * 15 - 5;
    //   y += random.nextDouble() * 20;
    //   if (y < size.height) {
    //     tornEdgePath.lineTo(size.width + xOffset, y);
    //   }
    // }
    //
    // // Bottom edge
    // x = size.width;
    // tornEdgePath.lineTo(x, size.height);
    // while (x > 0) {
    //   double yOffset = random.nextDouble() * 15 - 5;
    //   x -= random.nextDouble() * 20;
    //   if (x > 0) {
    //     tornEdgePath.lineTo(x, size.height + yOffset);
    //   }
    // }
    //
    // // Left edge
    // y = size.height;
    // tornEdgePath.lineTo(0, y);
    // while (y > 0) {
    //   double xOffset = random.nextDouble() * 15 - 5;
    //   y -= random.nextDouble() * 20;
    //   if (y > 0) {
    //     tornEdgePath.lineTo(xOffset, y);
    //   }
    // }
    // tornEdgePath.close();
    //
    // // 使用撕裂路径剪切画布
    // canvas.clipPath(tornEdgePath);
    // Paint paint = Paint();
    //
    // // 在这里加载并绘制您的图片218 107 62
    // // 作为示例，这里用一个矩形来代替图片
    // paint.color = Color.fromRGBO(218, 107, 62, .5);
    // canvas.drawRect(imageRect, paint);
    Paint paint = Paint();
    // 添加褪色效果
    _addFadedEffect(canvas, size, paint);

    // 添加斑驳的灰尘和污渍层
    _addDustEffect(canvas, size, paint);

    // 添加裂纹效果
    _addCrackEffect(canvas, size, paint);

    // 可选：叠加纹理以增强纸张效果
    // 这里可以叠加一个半透明的纹理图片来增加真实感
  }

  // 模拟褪色效果
  void _addFadedEffect(Canvas canvas, Size size, Paint paint) {
    paint.style = PaintingStyle.fill;
    paint.color = Colors.brown.withOpacity(0.1);  // 褐色的色调模拟老化效果
    paint.blendMode = BlendMode.overlay;

    // 使用渐变叠加的方式模糊整个图像，模拟老照片的颜色失真
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    paint.shader = LinearGradient(
      colors: [Colors.white.withOpacity(0.1), Colors.transparent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  // 模拟斑驳的灰尘和污渍效果
  void _addDustEffect(Canvas canvas, Size size, Paint paint) {
    Random random = Random();

    paint.style = PaintingStyle.fill;
    paint.color = Colors.white.withOpacity(0.05);  // 轻微透明度的污点

    // 随机生成灰尘污渍
    for (double i = 0; i < size.width; i += 5) {
      for (double j = 0; j < size.height; j += 5) {
        if (random.nextDouble() > 0.97) {
          // 随机生成灰尘污渍的大小与位置
          paint.color = Color.fromRGBO(
              150 + random.nextInt(50), 150 + random.nextInt(50), 150 + random.nextInt(50), random.nextDouble() * 0.1);
          canvas.drawCircle(Offset(i + random.nextDouble() * 5, j + random.nextDouble() * 5), random.nextDouble() * 2, paint);
        }
      }
    }
  }

  // 模拟裂纹效果
  void _addCrackEffect(Canvas canvas, Size size, Paint paint) {
    Random random = Random();

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.0;
    paint.color = Colors.white.withOpacity(.5); // 淡色裂纹

    // 随机生成裂纹路径
    for (double i = 0; i < size.width; i += 40) {
      for (double j = 0; j < size.height; j += 40) {
        if (random.nextDouble() > 0.98) {
          // 生成裂纹
          double x = i + random.nextDouble() * 20;
          double y = j + random.nextDouble() * 20;
          double length = 50 + random.nextDouble() * 30;
          double width = 1.5 + random.nextDouble() * 1.5;

          paint.strokeWidth = width;
          canvas.drawLine(Offset(x, y), Offset(x + length, y + length), paint);
        }
      }
    }
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path tornEdgePath = Path();

    Random random = Random();

    // Top edge
    double x = 0;
    tornEdgePath.moveTo(x, 0);
    while (x < size.width) {
      double yOffset = random.nextDouble() * 15 - 5;
      x += random.nextDouble() * 20;
      if (x < size.width) {
        tornEdgePath.lineTo(x, yOffset);
      }
    }

    // Right edge
    double y = 0;
    tornEdgePath.lineTo(size.width, y);
    while (y < size.height) {
      double xOffset = random.nextDouble() * 15 - 5;
      y += random.nextDouble() * 30;
      if (y < size.height) {
        tornEdgePath.lineTo(size.width + xOffset, y);
      }
    }

    // Bottom edge
    x = size.width;
    tornEdgePath.lineTo(x, size.height);
    while (x > 0) {
      double yOffset = random.nextDouble() * 15 - 5;
      x -= random.nextDouble() * 20;
      if (x > 0) {
        tornEdgePath.lineTo(x, size.height + yOffset);
      }
    }

    // Left edge
    y = size.height;
    tornEdgePath.lineTo(0, y);
    while (y > 0) {
      double xOffset = random.nextDouble() * 15 - 5;
      y -= random.nextDouble() * 20;
      if (y > 0) {
        tornEdgePath.lineTo(xOffset, y);
      }
    }
    tornEdgePath.close();
    return tornEdgePath;
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
