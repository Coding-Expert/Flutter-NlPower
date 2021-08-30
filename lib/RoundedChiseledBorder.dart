

import 'package:flutter/material.dart';
import 'package:nlpower/RoundedBorderPainter.dart';

class RoundedChiseledBorder extends StatelessWidget {
  final Widget child;

  final Color leftBorderColor;
  final Color rightBorderColor;
  final Color bottomBorderColor;
  final Color topBorderColor;

  final double borderRadius;
  final double borderWidth;

  RoundedChiseledBorder({
    @required this.child,
    this.borderRadius = 1,
    this.borderWidth = 2,
    this.bottomBorderColor = Colors.transparent,
    this.topBorderColor = Colors.transparent,
    this.rightBorderColor = Colors.transparent,
    this.leftBorderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: RoundedBorderPainter(
              radius: borderRadius,
              strokeWidth: borderWidth,
              bottomBorderColor: bottomBorderColor,
              leftBorderColor: leftBorderColor,
              rightBorderColor: rightBorderColor,
              topBorderColor: topBorderColor,
            ),
          ),
        ),
        child,
      ],
    );
  }
}