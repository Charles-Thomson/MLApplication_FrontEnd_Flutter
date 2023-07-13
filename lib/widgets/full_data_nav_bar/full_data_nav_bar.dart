
import 'dart:math';

import 'package:ann_app/widgets/full_data_nav_bar/graph_data_processing.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/hero_route.dart';
import 'package:ann_app/widgets/full_data_nav_bar/full_data_graphs.dart';

const String _fulldatapopouttag = "animation-selection-pop-out";

class FullDataButton extends StatelessWidget{
  const FullDataButton({super.key, required this.payloadData});
  final List<List> payloadData;

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return FullDataPopOut(payloadData: payloadData);
            }
            )
            );
          },

          child: Hero(
              tag: _fulldatapopouttag,
              child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child: Icon(
                      Icons.animation_sharp,
                      size: 40,
                      color: Theme.of(context).primaryColor
                  )
              )
          ),
        )
    );
  }
}

class FullDataPopOut extends StatefulWidget{
  const FullDataPopOut({super.key, required this.payloadData});
  final List<List> payloadData;
  @override
  State<FullDataPopOut> createState() => _FullDataPopOut();

}

class _FullDataPopOut extends State<FullDataPopOut>{
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

    return Center(
      child: SingleChildScrollView(
        child: Hero(
            tag: _fulldatapopouttag,
            child: Container(
              height: 650,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey.shade700,
                      Colors.blueGrey.shade500,
                      Colors.blueGrey.shade300,
                      Colors.blueGrey.shade300,
                      Colors.blueGrey.shade400,
                      Colors.blueGrey.shade700,
                    ],
                    stops: const [0.01, 0.1, 0.49, 0.51, 0.6, 1],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  color: Colors.grey.withOpacity(0.8),
                  boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 1,
                      offset: const Offset(1, 1),
                      blurStyle: BlurStyle.solid
                  )],
                ),

                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                        children:    [
                           Expanded(
                             flex: 4,
                             child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
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
                ))
        ),
      ),
    );
  }
}


