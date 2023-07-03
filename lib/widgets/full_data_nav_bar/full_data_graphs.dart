import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/full_data_nav_bar/graph_data_processing.dart';
import 'dart:convert';

class CustomLineChart extends StatelessWidget{
  const CustomLineChart({super.key, required this.dataSet});

  final String dataSet;


  // List<double> lineBarData ;
  // var double xAxisMax - xAxisMin
  // var double yAxisMax - yAxisMin


  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.2),
    ),
  );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: Colors.blue.withOpacity(0.2), width: 4),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );


  FlTitlesData get titlesData1 => FlTitlesData(

    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
      axisNameWidget: const Text("Step", style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: Colors.blue
      ),),
      axisNameSize: 18

    ),
    rightTitles:  AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),


    topTitles:  AxisTitles(
      sideTitles: topTiles(),
    ),


    leftTitles: AxisTitles(
      axisNameWidget: const Text("Fitness", style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        color: Colors.blue
      ),),
      axisNameSize: 18,
      sideTitles: leftTitles(),
    ),
  );

  SideTitles topTiles() => SideTitles(
    getTitlesWidget: topTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgetsV2,
    showTitles: true,
    interval: 1,
    reservedSize: 30,
  );

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 28,
    interval: 1,
    getTitlesWidget: bottomTitleWidgetsV2,
  );


Widget bottomTitleWidgetsV2 (double value, TitleMeta meta){
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    int newValue = value.round();

    return Text(newValue.toString(), style: style, textAlign: TextAlign.center);
  }

Widget leftTitleWidgetsV2 (double value, TitleMeta meta){
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  return Text(value.toString(), style: style, textAlign: TextAlign.center);
}

  Widget topTitleWidgets(double value, TitleMeta meta) {

    Widget text;
    text = const Text("");
    if(value == 6.0){
      text = const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Generation Data",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.lightBlue
            ), textAlign: TextAlign.center
        ),
      );
    }

    return text;
  }

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    curveSmoothness: 0.1,
    isCurved: true,
    color: Colors.white,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData:  FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 6),
      FlSpot(3, 1.5),
      FlSpot(5, 1.4),
      FlSpot(7, 3.4),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    color: Colors.pink,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData:  FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
      color: Colors.pink.withOpacity(0),
    ),
    spots: const [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
  );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
    isCurved: true,
    color: Colors.cyan,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData:  FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 2.8),
      FlSpot(3, 1.9),
      FlSpot(6, 3),
      FlSpot(10, 1.3),
      FlSpot(13, 2.5),
    ],
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
    lineChartBarData1_3,
  ];

  @override
  Widget build(BuildContext context){

    processJsonData(dataSet);
    return  Material(
      color: Colors.transparent,
      child: LineChart(
          LineChartData(
            backgroundColor: Colors.transparent,
            lineTouchData: lineTouchData1,
            titlesData: titlesData1,
            gridData: gridData,
            borderData: borderData,
            lineBarsData: lineBarsData1,

            minX: 0,
            maxX: 14,
            maxY: 6,
            minY: 0,
      )

      ),
    );
  }

}