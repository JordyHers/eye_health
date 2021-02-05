import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String usage;
  String days;
  int time;
  final charts.Color color;

  BarChartModel({this.usage,
    this.days, this.time,
    this.color,}
      );
}