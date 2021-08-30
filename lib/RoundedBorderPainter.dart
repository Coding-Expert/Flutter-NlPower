import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vm;

class RoundedBorderPainter extends CustomPainter {
  final Color leftBorderColor;
  final Color rightBorderColor;
  final Color bottomBorderColor;
  final Color topBorderColor;
  final double strokeWidth;
  final StrokeCap strokeCap = StrokeCap.round;
  double radius;

  Size size;

  RoundedBorderPainter({
    this.leftBorderColor = Colors.black,
    this.rightBorderColor = Colors.black,
    this.topBorderColor = Colors.black,
    this.bottomBorderColor = Colors.black,
    this.strokeWidth = 0,
    this.radius = 1,
  }) {
    if (radius <= 1) this.radius = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    radius = size.shortestSide / 2 < radius ? size.shortestSide / 2 : radius;
    this.size = size;
    Paint topPaint = Paint()
      ..color = topBorderColor
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;
    Paint rightPaint = Paint()
      ..color = rightBorderColor
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    Paint bottomPaint = Paint()
      ..color = bottomBorderColor
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    Paint leftPaint = Paint()
      ..strokeCap = strokeCap
      ..color = leftBorderColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(getPath1(), topPaint);
    canvas.drawPath(getPath2(), rightPaint);
    canvas.drawPath(getPath3(), bottomPaint);
    canvas.drawPath(getPath4(), leftPaint);
  }

  Path getPath1() {
    return Path()
      ..addPath(getTopLeftPath2(), Offset(0, 0))
      ..addPath(getTopPath(), Offset(0, 0))
      ..addPath(getTopRightPath1(), Offset(0, 0));
  }

  Path getPath2() {
    return Path()
      ..addPath(getTopRightPath2(), Offset(0, 0))
      ..addPath(getRightPath(), Offset(0, 0))
      ..addPath(getBottomRightPath1(), Offset(0, 0));
  }

  Path getPath3() {
    return Path()
      ..addPath(getBottomRightPath2(), Offset(0, 0))
      ..addPath(getBottomPath(), Offset(0, 0))
      ..addPath(getBottomLeftPath1(), Offset(0, 0));
  }

  Path getPath4() {
    return Path()
      ..addPath(getBottomLeftPath2(), Offset(0, 0))
      ..addPath(getLeftPath(), Offset(0, 0))
      ..addPath(getTopLeftPath1(), Offset(0, 0));
  }

  Path getTopPath() {
    return Path()
      ..moveTo(0 + radius, 0)
      ..lineTo(size.width - radius, 0);
  }

  Path getRightPath() {
    return Path()
      ..moveTo(size.width, 0 + radius)
      ..lineTo(size.width, size.height - 0);    ////////
  }

  Path getBottomPath() {
    return Path()
      ..moveTo(size.width , size.height - 0.5) ////////  (bottom line)
      ..lineTo(0 , size.height - 0.5);            ////////  (bottom line)
  }

  Path getLeftPath() {
    return Path()
      ..moveTo(0 , size.height)        //////////
      ..lineTo(0, 0 + radius);
  }

  Path getTopRightPath1() {
    return Path()
      ..addArc(
        Rect.fromLTWH(size.width - (radius * 2), 0, radius * 2, radius * 2),
        vm.radians(-45),
        vm.radians(-45),
      );
  }

  Path getTopRightPath2() {
    return Path()
      ..addArc(
        Rect.fromLTWH(size.width - (radius * 2), 0, radius * 2, radius * 2),
        vm.radians(0),
        vm.radians(-45),
      );
  }

  Path getBottomRightPath1() {
    return Path()
      ..addArc(
        Rect.fromLTWH(size.width - (0 * 2), size.height - (0 * 2), 0, 0), ///////
        vm.radians(45),
        vm.radians(-45),
      );
  }

  Path getBottomRightPath2() {
    return Path()
      ..addArc(
        Rect.fromLTWH(size.width - (0 * 2), size.height - (0 * 2), 0, 0), ////////
        vm.radians(90),
        vm.radians(-45),
      );
  }

  Path getBottomLeftPath1() {
    return Path()
      ..addArc(
        Rect.fromLTWH(0, size.height - (0 * 2), 0,  0), //////
        vm.radians(135),
        vm.radians(-45),
      );
  }

  Path getBottomLeftPath2() {
    return Path()
      ..addArc(
        Rect.fromLTWH(0, size.height - (0 * 2), 0, 0),
        vm.radians(180),
        vm.radians(-45),
      );
  }

  Path getTopLeftPath1() {
    return Path()
      ..addArc(
        Rect.fromLTWH(0, 0, radius * 2, radius * 2),
        vm.radians(225),
        vm.radians(-45),
      );
  }

  Path getTopLeftPath2() {
    return Path()
      ..addArc(
        Rect.fromLTWH(0, 0, radius * 2, radius * 2),
        vm.radians(270),
        vm.radians(-45),
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}