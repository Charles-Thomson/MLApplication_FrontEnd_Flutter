
import 'package:ann_app/widgets/full_data_nav_bar/graph_data_processing.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/hero_route.dart';
import 'package:ann_app/widgets/full_data_nav_bar/full_data_graphs.dart';

import 'graph_test_data.dart';

const String _fulldatapopouttag = "animation-selection-pop-out";

class FullDataButton extends StatelessWidget{
  const FullDataButton({super.key});
  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return const FullDataPopOut();
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
  const FullDataPopOut({super.key});

  @override
  State<FullDataPopOut> createState() => _FullDataPopOut();

}

class _FullDataPopOut extends State<FullDataPopOut>{
  List<int> selectedValue = [];
  var testData = jsonGraphTestData;

  double get getMaxX => getMaxXValue(testData);
  double get getMaxY => getMaxYValue(testData);
  int get numberOfGenerations => getNumberOfGenerations(testData);
  List<LineChartBarData> get getSelectedLineBarsData => generateLineChartBarData(testData, selectedValue);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 100, 5, 60),
          child: Hero(
              tag: _fulldatapopouttag,
              child: Container(
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
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children:    [
                            const SizedBox(
                                height: 40,
                            ),

                             Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                              child: SizedBox(
                                height: 400,
                                width: 400,
                                // -> xAxis, yAxis, Selected Data
                                child: CustomLineChart(maxXAxis: getMaxX, maxYAxis: getMaxY,lineChartPlots: getSelectedLineBarsData),
                                ),
                            ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Wrap(
                                 spacing: 5,
                                 direction: Axis.horizontal,
                                 children: List<Widget>.generate(numberOfGenerations,(int index){
                                   return ChoiceChip(
                                      backgroundColor: Colors.blue,
                                       selectedColor: Colors.red,
                                       label: Text("Generation $index"),
                                       avatar: CircleAvatar(
                                           child: Icon(selectedValue.contains(index) ? Icons.check : Icons.circle)
                                       ),
                                       selected: selectedValue.contains(index),
                                       onSelected: (bool selected){
                                         setState(() {
                                           selectedValue.contains(index) ? selectedValue.remove(index) : selectedValue.add(index);

                                         });
                                         //print(selectedValue);
                                       },
                                   );
                                 }
                                 ).toList()
                               ),
                             )

                          ]
                      ),
                    ),
                  ))
          )
      ),
    );
  }
}


