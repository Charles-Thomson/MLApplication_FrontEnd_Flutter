import 'package:flutter/material.dart';
import 'package:ann_app/widgets/dropdownselector.dart';
import 'package:ann_app/widgets/function_selection_widgets/function_selection_nav_bar.dart';

import 'package:ann_app/widgets/nav_bar_buttons/hero_route.dart';
const String _functionspopouttag = "functions-pop-out";

class FunctionSettingsButton extends StatelessWidget{
  const FunctionSettingsButton({super.key, required this.updateConfigData});

  final Function(String, String) updateConfigData;

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context){
              return const FunctionSettingsButtonPopOut();
            }));
          },
          child: Hero(
              tag: _functionspopouttag,
              child: Material(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child: const Icon(
                      Icons.functions,
                      size: 40,
                      color: Colors.white
                  )
              )
          ),
        )
    );
  }
}

class FunctionSettingsButtonPopOut extends StatefulWidget{
  const FunctionSettingsButtonPopOut({super.key});

  @override
  State<FunctionSettingsButtonPopOut> createState() => _FunctionSettingsButtonPopOut();
}

class _FunctionSettingsButtonPopOut extends State<FunctionSettingsButtonPopOut>{
  // final Function(String, String) updateConfigData;
  final  menuItems = ["Weight Heuristic","HE", "xavier", "normalized xavier"];
  final String configKey = "WEIGHT_INITALIZATION_HEURISTIC";

  Widget selectedCard = const ActivationCard();

  @override
  Widget build(BuildContext context) {



    void changeVisableCard(String newCard){
      print("Button called at top level");
      if (newCard == "WeightCard"){
        Future.delayed(Duration.zero,(){
          setState(() {
            selectedCard = const WeightCard();
          });
        }
        );
      }
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
                             SizedBox(
                                height: 40,
                                child: Material(
                                  color: Colors.white.withOpacity(0),
                                  child: const Text(
                                      style: TextStyle(fontSize: 20)
                                      ,"FUNCTION SELECTION "),
                                )
                            ),
                            // place holder for the tile to be shown
                            const SizedBox(
                              height: 430,
                              child: Center(
                                  child: ActivationCard()
                              )
                            ),
                            // cal back of a set state to the new shown tile
                            SizedBox(
                              height: 80,
                              child: FunctionSelectionNavBar(changeVisableCardCallBack: (newCard){
                                changeVisableCard(newCard);
                              }),
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

class ActivationCard extends StatelessWidget{
  const ActivationCard({super.key});

  @override
  Widget build(BuildContext context){
    return Container(

        color: Colors.white,
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   const [
               SizedBox(
                  height: 40,
                  child: Material(
                    child: Text(
                        style: TextStyle(fontSize: 20)
                        ,"Activation Functions"),
                  )
              ),
               SizedBox(
                  height: 10
              ),
              SizedBox(
                  height: 100,
                  width: 300,
                  // child: DropDownMenu(updateConfigData, menuItems, configKey)
              )
            ]
        )
    );
  }
}

class WeightCard extends StatelessWidget{
  const WeightCard({super.key});

  @override
  Widget build(BuildContext context){
    return Container(

        color: Colors.white,
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   const [
              SizedBox(
                  height: 40,
                  child: Material(
                    child: Text(
                        style: TextStyle(fontSize: 20)
                        ,"Weight Heuristic"),
                  )
              ),
              SizedBox(
                  height: 10
              ),
              SizedBox(
                height: 100,
                width: 300,
                // child: DropDownMenu(updateConfigData, menuItems, configKey)
              )
            ]
        )
    );
  }
}



