import 'package:flutter/material.dart';

import 'package:ann_app/widgets/function_selection_widgets/selection_cards/hidden_activation_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/output_activation_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/activation_function_landing_card.dart';

class ActivationCard extends StatefulWidget{
  const ActivationCard({super.key, required this.updateConfigData});

  final Function(String, String) updateConfigData;

  @override
  State<ActivationCard> createState() => _ActivationCard();

}

class _ActivationCard extends State<ActivationCard>{
  get updateConfigData => widget.updateConfigData;
  Widget currentCard = const ActivationFunctionsLandingCard();


  @override
  Widget build(BuildContext context){
    var availableCards = {
      "HiddenActivation": HiddenActivationCard(updateConfigData: updateConfigData),
      "OutputActivation":  OutputActivationCard(updateConfigData: updateConfigData),
    };

    void updateCard(String newCard){
      Widget newSelectedCard = availableCards[newCard] as Widget;
      setState(() {
        currentCard = newSelectedCard;
      });
    }

    return Container(
        color: Colors.white,
        child:
        Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children:    [
               Center(
                 child: Material(
                   child: SizedBox(
                     height: 380,
                       child: currentCard
                   )

                 ),
               ),
              SizedBox(
                height: 60,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 120,
                      child: TextButton.icon(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {updateCard("HiddenActivation");} ,
                        icon: Column(
                            children: const [
                              Icon(
                                  Icons.input_sharp,
                                  color: Colors.black,
                                  size: 30
                              ),
                              Text("Hidden Activation",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontSize: 12)
                              )
                            ]
                        ),
                        label: const Text("",//''),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 120,
                      child: TextButton.icon(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {updateCard("OutputActivation");} ,
                        icon: Column(
                            children: const [
                              Icon(
                                  Icons.output_sharp,
                                  color: Colors.black,
                                  size: 30
                              ),
                              Text("Output Activation",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontSize: 12)
                              )
                            ]
                        ),
                        label: const Text("",//''),
                        ),
                      ),
                    ),




                  ]
                )

              )
            ]
        )
    );
  }
}