import 'package:flutter/material.dart';

import 'package:ann_app/widgets/function_selection_widgets/function_selection_nav_bar.dart';

import 'package:ann_app/widgets/hero_route.dart';

import 'package:ann_app/widgets/function_selection_widgets/selection_cards/activation_function_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/weight_heuristic_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/genertion_concatenation_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/landing_card.dart';


const String _functionspopouttag = "functions-pop-out";

class FunctionSettingsButton extends StatelessWidget{
  const FunctionSettingsButton({super.key, required this.updateConfigData});
  final Function(String, String) updateConfigData;

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                return FunctionSettingsButtonPopOut(updateConfigData: updateConfigData);
              }
            )
          );
        },

          child: Hero(
              tag: _functionspopouttag,
              child: Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child:  Icon(
                      Icons.functions,
                      size: 40,
                      color: Theme.of(context).primaryColor
                  )
              )
          ),
        )
    );
  }
}

class FunctionSettingsButtonPopOut extends StatefulWidget{
  const FunctionSettingsButtonPopOut({super.key, required this.updateConfigData});

  final Function(String, String) updateConfigData;



  @override
  State<FunctionSettingsButtonPopOut> createState() => _FunctionSettingsButtonPopOut();

}

class _FunctionSettingsButtonPopOut extends State<FunctionSettingsButtonPopOut>{
  Widget currentCard = const InfoCard();
  get updateConfigData => widget.updateConfigData;

  @override
  Widget build(BuildContext context) {
    var availableCards = {
      "ActivationFunction": ActivationCard(updateConfigData: updateConfigData),
      "WeightHeuristic":  WeightCard(updateConfigData: updateConfigData),
      "GenerationConcatenation": ConcatenationCard(updateConfigData: updateConfigData)
    };

    void callbackUpdateCard(String newCard){
      Widget newSelectedCard = availableCards[newCard] as Widget;
      setState(() {
        currentCard = newSelectedCard;
      });
    }

    


    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Hero(
              tag: _functionspopouttag,
              child: Container(
                  height: 600,
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
                    color: Colors.grey.withOpacity(0.6),
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                        blurStyle: BlurStyle.solid
                    )],
                  ),

                  child: Center(child:
                  Container(
                      height: 560,
                      width: 340,
                      color: Colors.white.withOpacity(0.7),
                      child:

                      Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children:    [
                             Flexible(
                               flex: 1,
                               child: SizedBox(
                                  height: 30,
                                  child: Material(
                                    color: Colors.white.withOpacity(0),
                                    child: const Text(
                                        style: TextStyle(fontSize: 20)
                                        ,"PROCESS SELECTION "),
                                  )
                            ),
                             ),
                            // place holder for the tile to be shown
                             Flexible(
                               flex: 12,
                               child: SizedBox(
                                height: 440,
                                width: 320,
                                child: Center(
                                    child: currentCard
                                )
                            ),
                             ),
                            // cal back of a set state to the new shown tile
                            Flexible(
                              flex:2,
                              child: SizedBox(
                                height: 90,
                                child: FunctionSelectionNavBar(
                                    changeVisableCardCallBack: (newCard){
                                  callbackUpdateCard(newCard);
                                }),
                              ),
                            ),
                          ]
                      )
                  )
                  ))
          )
      ),
    );
  }
}





