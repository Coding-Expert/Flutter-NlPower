import 'package:flutter/material.dart';

class LineData {
  Map<String, double> data = new Map();
  String category;
  Color color;

  LineData(String category, Color color, List<double> values) {
    this.data = createCumulativeData(values);
    this.category = category;
    this.color = color;
  }

  Map<String, double> createCumulativeData(List<double> values) {
    Map<String, double> data = new Map();
    int c = 0;
    double sum = 0;
    values.forEach((element) {
      sum += element;
      data.putIfAbsent(c.toString(), () => sum);
      c++;
    });
    return data;
  }
}