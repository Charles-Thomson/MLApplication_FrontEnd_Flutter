
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ann_app/widgets/hero_route.dart';
import 'package:ann_app/widgets/full_data_nav_bar/full_data_graphs.dart';

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

  var testData = {
    "number_of_generations": "3",
    "max_steps": "10",
    "max_fitness": "10.0",
    "payloadData": {
    "gen_0": {
      "total_steps": "10",
      "total_fitness": "10.0",
      "fitness_by_step":
      [0.0,
        1.2,
        3.4,
        6.6,
        6.8,
        7.5,
        8.0,
        9.5,
        10]
    },
      "gen_1": {
        "total_steps": "10",
        "total_fitness": "10.0",
        "fitness_by_step":
        [0.1,
          1.2,
          3.4,
          6.6,
          6.8,
          7.5,
          8.0,
          9.5,
          10]
      },
      "gen_2": {
        "total_steps": "10",
        "total_fitness": "10.0",
        "fitness_by_step":
        [0.2,
          1.2,
          3.4,
          6.6,
          6.8,
          7.5,
          8.0,
          9.5,
          10]
      }
    },
  };





  @override
  Widget build(BuildContext context) {
    var thisData = json.encode(testData);
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                        children:    [
                          SizedBox(
                              height: 40,
                              child: Material(
                                color: Colors.white.withOpacity(0),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      style: TextStyle(fontSize: 20)
                                      ,"Full Generation Data"),
                                ),
                              )
                          ),

                           Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                            child: SizedBox(
                              height: 400,
                              width: 400,
                              // Want to pass in:
                              // Axis Sizes
                              // Then full data
                              child: CustomLineChart(dataSet: thisData),

                              ),
                          ),

                        ]
                    ),
                    ),
                  ))
          )
      ),
    );
  }
}


