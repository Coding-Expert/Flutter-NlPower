

import 'package:flutter/material.dart';
import 'package:nlpower/model/linechartpainter.dart';
import 'package:nlpower/model/linedata.dart';

class LineChart extends StatefulWidget {

  double m_height;
  LineChart({
    this.m_height
  });

  LineChartState createState()=> LineChartState();
}

class LineChartState extends State<LineChart> {
  static List<double> hamilton = [0, 12, 25, 26, 25, 19, 25, 25, 7, 26, 15, 25];
  static List<double> bottas = [0, 25, 18, 15, 0, 15, 16, 18, 10, 18, 26, 0];
  static List<double> max = [0, 0, 15, 18, 19, 25, 18, 15, 0, 0, 18, 19];

  final List<LineData> data = [
    LineData("", Color(0xfffa913a), hamilton),
    LineData("", Color(0xff00aee8), bottas),
    LineData("", Color(0xff00ff21), max)
  ];

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 100),
        duration: Duration(seconds: 2),
        builder: (BuildContext context, double percentage, Widget child) {
          return CustomPaint(
            painter:
                LineChartPainter(percentage, data, "Top Three Formula One"),
            child: Container(width: double.infinity, height: widget.m_height),
          );
        });
  }
}