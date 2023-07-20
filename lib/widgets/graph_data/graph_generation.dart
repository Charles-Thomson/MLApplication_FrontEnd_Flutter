import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineChart extends StatelessWidget{
  const CustomLineChart({super.key, required this.maxXAxis, required this.maxYAxis, required this.lineChartPlots});

  final double maxXAxis;
  final double maxYAxis;
  final List<LineChartBarData> lineChartPlots;

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
      BorderSide(color: Colors.black12.withOpacity(0.8), width: 4),
      left: const BorderSide(color: Colors.black),
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
          letterSpacing: 1.2,
          color: Colors.blue
      ),),
      axisNameSize: 18

    ),
    rightTitles:  AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),


    topTitles:  AxisTitles(
      axisNameWidget: const Text("Generation Data",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              color: Colors.lightBlue
          ), textAlign: TextAlign.center
      ),
      axisNameSize: 30,
      sideTitles: topTiles(),
    ),


    leftTitles: AxisTitles(
      axisNameWidget: const Text("Fitness", style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
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
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,

  );

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 35,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );


Widget bottomTitleWidgets (double value, TitleMeta meta){
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    int newValue = value.round();

    return Text(newValue.toString(), style: style, textAlign: TextAlign.center);
  }

Widget leftTitleWidgets (double value, TitleMeta meta){

  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  return Text(value.toString(), style: style, textAlign: TextAlign.center);
}

  // Deprecated depending on Title tile of topTile
  Widget topTitleWidgets(double value, TitleMeta meta) => const Text("");

  @override
  Widget build(BuildContext context){
    return  Material(
      color: Colors.transparent,
      child: LineChart(
          LineChartData(
            backgroundColor: Colors.transparent,
            lineTouchData: lineTouchData1,
            titlesData: titlesData1,
            gridData: gridData,
            borderData: borderData,
            lineBarsData: lineChartPlots,
            minX: 0,
            maxX: maxXAxis + 1,
            maxY: maxYAxis + 1,
            minY: 0,
      )

      ),

    );
  }

}