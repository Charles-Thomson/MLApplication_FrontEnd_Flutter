import 'package:ann_app/widgets/function_selection_widgets/scrollable_selection.dart';
import 'package:flutter/material.dart';

import 'package:ann_app/widgets/function_selection_widgets/function_selection_nav_bar.dart';

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
          padding: const EdgeInsets.fromLTRB(5, 100, 5, 60),
          child: Hero(
              tag: _functionspopouttag,
              child: ClipPath(
                clipper: BottomNotchClipper(),
                child: Container(

                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(6),
                    //   border: Border.all(width: 0),
                    //   gradient: LinearGradient(
                    //     colors: [
                    //       themePrimary.shade700,
                    //       themePrimary.shade500,
                    //       themePrimary.shade300,
                    //       themePrimary.shade300,
                    //       themePrimary.shade400,
                    //       themePrimary.shade700,
                    //     ],
                    //     stops: const [0.01, 0.1, 0.49, 0.51, 0.6, 1],
                    //     begin: Alignment.centerLeft,
                    //     end: Alignment.centerRight,
                    //   ),
                    //   color: themePrimary.withOpacity(0.6),
                    //   boxShadow: [BoxShadow(
                    //       color: Colors.grey.withOpacity(0.6),
                    //       blurRadius: 1,
                    //       offset: const Offset(1, 1),
                    //       blurStyle: BlurStyle.solid
                    //   )],
                    // ),

                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ScrollAbleFunctionSelection(updateConfigData: updateConfigData,),
                    )),
              ))));
  }
}





