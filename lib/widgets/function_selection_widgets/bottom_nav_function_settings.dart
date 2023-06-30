import 'package:ann_app/widgets/function_selection_widgets/scrollable_selection.dart';
import 'package:flutter/material.dart';

import 'package:ann_app/widgets/hero_route.dart';

import 'package:ann_app/widgets/function_selection_widgets/selection_cards/activation_function_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/weight_heuristic_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/genertion_concatenation_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/landing_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/bottom_notch_clipper.dart';


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
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child:  Icon(
                      Icons.functions,
                      size: 40,
                      color: Theme.of(context).primaryColor,


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
    MaterialColor themePrimary = Theme.of(context).primaryColor as MaterialColor;
    // var availableCards = {
    //   "ActivationFunction": ActivationCard(updateConfigData: updateConfigData),
    //   "WeightHeuristic":  WeightCard(updateConfigData: updateConfigData),
    //   "GenerationConcatenation": ConcatenationCard(updateConfigData: updateConfigData)
    // };
    //
    // void callbackUpdateCard(String newCard){
    //   Widget newSelectedCard = availableCards[newCard] as Widget;
    //   setState(() {
    //     currentCard = newSelectedCard;
    //   });
    // }

    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 100, 5, 60),
          child: Hero(
              tag: _functionspopouttag,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ScrollAbleFunctionSelection(updateConfigData: updateConfigData,),
              ))));
  }
}





