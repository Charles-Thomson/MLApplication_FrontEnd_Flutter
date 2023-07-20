
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


List<LineChartBarData> generateSelectedLineChartData(List<List> barChartDataWithColor, List<int> selectedValues){

  List<LineChartBarData> builtLineBarChatData = [];

  for(int value in selectedValues){
    List<dynamic> thisData = barChartDataWithColor[value];
    List<dynamic> thisPlotPoints = thisData[0];
    List<FlSpot> newSpotPoints = buildFLSpotPoints(thisPlotPoints);
    LineChartBarData newLineBarChartData = buildLineBarChartData(newSpotPoints, thisData[1]);
    builtLineBarChatData.add(newLineBarChartData);
  }
  return builtLineBarChatData;
}

// Building the full LineBarChartData Element
LineChartBarData buildLineBarChartData(List<FlSpot> newSpotPoints, Color selectedColor){
  LineChartBarData newLineChartBarData = LineChartBarData(
      curveSmoothness: 0.0,
      isCurved: true,
      color: selectedColor,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData:  FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: newSpotPoints,
);

    return newLineChartBarData;
}

// Building the Data points
List<FlSpot> buildFLSpotPoints(List plotPoints){
  List<FlSpot> builtPoints = [];
  List<double>? doublePlotPoints = plotPoints.map((item) => item.toDouble()).cast<double>().toList();

  for(int index = 0; index < plotPoints.length; index++){
    double step = index.toDouble();
    double fitness = doublePlotPoints[index];
    FlSpot newPoint = FlSpot(step, fitness);
    builtPoints.add(newPoint);
  }

  return builtPoints;

}
