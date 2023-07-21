import 'dart:math';
import 'package:ann_app/widgets/graph_data/graph_data_formatting.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/graph_data//graph_generation.dart';

class GraphUIHero extends StatefulWidget{
  const GraphUIHero({super.key, required this.payloadData, required this.heroTag});
  final List<List> payloadData;
  final String heroTag;

  @override
  State<GraphUIHero> createState() => _GraphUIHero();
}

class _GraphUIHero extends State<GraphUIHero>{
  List<int> selectedValue = [];

  double get getMaxX => getMaxXAxisValue(widget.payloadData);
  double get getMaxY => getMaxYAxisValue(widget.payloadData);
  int get numberOfGenerations => widget.payloadData.length;

  late List<List> barChartDataWithColor;

  @override
  void initState(){
    super.initState();
    barChartDataWithColor = buildChartDataWithColor();

  }

  // Breaking the payload into fitness by step and assigning a color for the graph
  List<List> buildChartDataWithColor(){
    List<List> builtElements = [];
    for(List instance in widget.payloadData){
      List instanceData = [];
      List data = instance[2];
      Color selectedColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

      instanceData.add(data);
      instanceData.add(selectedColor);

      builtElements.add(instanceData);
    }

    return builtElements;
  }

  // Pass all the fitness by step w/ assigned colour to the graph builder, builder handles which are to be built base on selected values
  List<LineChartBarData> get buildSelectedLineCharts => generateSelectedLineChartData(barChartDataWithColor, selectedValue);

  // Highest number of steps
  getMaxXAxisValue(List<List> payloadData){
    double highestSteps = 0.0;
    for(List instance in payloadData){
      if(instance[1].length.toDouble() > highestSteps){
        int val = instance[1].length;
        highestSteps = val.toDouble();
      }
    }
    return highestSteps;
  }

  // Highest Fitness value
  double getMaxYAxisValue(payloadData){
    double highestFitness = 0.0;
    for(List instance in payloadData){
      if(instance[0] > highestFitness){
        highestFitness = instance[0];
      }
    }
    return double.parse(highestFitness.toStringAsExponential(0));
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, kBottomNavigationBarHeight),
        child: Hero(
          tag: widget.heroTag,
          child: SingleChildScrollView(
            child: Container(
                color: Colors.white.withOpacity(0.7),
                height: MediaQuery.of(context).size.height / 1.1,
                width:MediaQuery.of(context).size.width,
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                        children:    [
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomLineChart(maxXAxis: getMaxX, maxYAxis: getMaxY,lineChartPlots: buildSelectedLineCharts),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  spacing: 5,
                                  direction: Axis.horizontal,
                                  children: List<Widget>.generate(barChartDataWithColor.length,(int index){
                                    return ChoiceChip(
                                      backgroundColor: barChartDataWithColor[index][1],
                                      selectedColor: barChartDataWithColor[index][1],
                                      label: Text("Generation $index"),
                                      avatar: CircleAvatar(
                                          child: Icon(selectedValue.contains(index) ? Icons.check : Icons.circle)
                                      ),
                                      selected: selectedValue.contains(index),
                                      onSelected: (bool selected){
                                        setState(() {
                                          selectedValue.contains(index) ? selectedValue.remove(index) : selectedValue.add(index);
                                        });
                                      },
                                    );
                                  }
                                  ).toList()
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}