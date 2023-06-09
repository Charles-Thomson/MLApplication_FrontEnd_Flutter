import 'package:flutter/material.dart';
import 'package:ann_app/widgets/dropdownselector.dart';

import 'package:ann_app/widgets/nav_bar_buttons/hero_route.dart';
const String _weightpopouttag = "weight-pop-out";
class WeightHeuristicNavButton extends StatelessWidget{
  const WeightHeuristicNavButton({super.key, required this.updateWeightHeuristic});

  final Function(String) updateWeightHeuristic;

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context){
              return WeightPopOutTile(updateWeightHeuristic: (newWeightHeuristic){
                updateWeightHeuristic(newWeightHeuristic);
              });
            }));
          },
          child: Hero(
              tag: _weightpopouttag,
              child: Material(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child: const Icon(
                      Icons.line_weight,
                      size: 40
                  )
              )
          ),
        )
    );
  }
}


class WeightPopOutTile extends StatefulWidget{
  const WeightPopOutTile({super.key, required this.updateWeightHeuristic});

  final Function(String) updateWeightHeuristic;
  @override
  State<WeightPopOutTile> createState() => _WeightPopOutTile();

}

class _WeightPopOutTile extends State<WeightPopOutTile> {

  //set currentSelectedValue(String? currentSelectedValue) {}
  String? currentSelectedValue = "Weight Heuristic";
  var menuItems = ["Weight Heuristic","1", "2", "3"];

  get updateSelectedValue => widget.updateWeightHeuristic;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 400, 20, 10),
        child: Hero(
            tag: _weightpopouttag,
            child: Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 0),
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
                color: Colors.grey,
                boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 1,
                    offset: const Offset(1, 1),
                    blurStyle: BlurStyle.solid
                )],
              ),

              child: Center(child:
              Container(
                height: 170,
                width: 340,
                color: Colors.white,
                child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:   [
                    const SizedBox(
                      height: 40,
                      child: Material(
                        child: Text(
                            style: TextStyle(fontSize: 20)
                            ,"Test Title "),
                      )
                    ),
                     const SizedBox(
                       height: 10
                     ),
                     SizedBox(
                       height: 100,
                       width: 300,
                       child: DropDownMenu(updateSelectedValue, menuItems, "Weight Heuristic")
                     )
                    ]
                  )
              )
              ))
            )
        ),
      );
  }
}

