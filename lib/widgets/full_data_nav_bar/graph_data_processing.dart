import 'dart:convert';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<LineChartBarData> generateLineChartBarData(var dataSet, List<int> selectedGenerations){
  var data = json.decode(dataSet);

  int numberOfGenerations = int.parse(data["number_of_generations"]);

  var payloadData = data["payloadData"];
  List<LineChartBarData> builtLineBarChatData = [];

  for(int i = 0; i < numberOfGenerations ; i++){
    List<dynamic> thisPlotPoints = payloadData["gen_$i"]["fitness_by_step"];
    List<FlSpot> newSpotPoints = buildFLSpotPoints(thisPlotPoints);
    LineChartBarData newLineBarChartData = buildLineBarChartData(newSpotPoints);
    builtLineBarChatData.add(newLineBarChartData);
  }
  List<LineChartBarData> selectedBuiltLineBarChatData = [];

  // Add the selected ges to the return list
  for(var x in selectedGenerations){
    selectedBuiltLineBarChatData.add(builtLineBarChatData[x]);

  }

  return selectedBuiltLineBarChatData;
}

getGenerationData(dataSet, generationNumber){
  var data = json.decode(dataSet);
  var payloadData = data["payloadData"];
  var generationData = payloadData["gen_$generationNumber"];
  return generationData;
}

double getMaxXValue(dataSet){
  var data = json.decode(dataSet);
  double maxSteps = double.parse(data["max_steps"]);
  return maxSteps;
}

double getMaxYValue(dataSet){
  var data = json.decode(dataSet);
  double maxFitness = double.parse(data["max_fitness"]);
  return maxFitness;
}

int getNumberOfGenerations(dataSet){
  var data = json.decode(dataSet);
  int numberOfGenerations = int.parse(data["number_of_generations"]);
  return numberOfGenerations;

}

// Building the full LineBarChartData Element
LineChartBarData buildLineBarChartData(List<FlSpot> newSpotPoints){
  LineChartBarData newLineChartBarData = LineChartBarData(
      curveSmoothness: 0.0,
      isCurved: true,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
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
