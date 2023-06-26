import 'package:flutter/material.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/activation_function_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/weight_heuristic_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/genertion_concatenation_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/hidden_activation_selection_card.dart';
import 'package:ann_app/widgets/function_selection_widgets/selection_cards/output_activation_selection_card.dart';

import 'package:ann_app/widgets/dropdownselector.dart';
class ScrollAbleFunctionSelection extends StatefulWidget{
  const ScrollAbleFunctionSelection({super.key, required this.updateConfigData});
  final Function(String, String) updateConfigData;

  @override
  State<ScrollAbleFunctionSelection> createState() => _ScrollAbleFunctionSelection();

  }

  class _ScrollAbleFunctionSelection extends State<ScrollAbleFunctionSelection>{
    get updateConfigData => widget.updateConfigData;

  @override
    Widget build(BuildContext context){
    List<Widget> functionSelectionCards = [
      WeightCard(updateConfigData: updateConfigData),
      HiddenActivationCard(updateConfigData: updateConfigData),
      OutputActivationCard(updateConfigData: updateConfigData),
      ConcatenationCard(updateConfigData: updateConfigData)
    ];
    var dataSet = {
      "0": {"title": "Weight",
            "dropDownMenuItems": "test,test2,test3",
            "configKey" : "test"

      },

      "1": {"title": "Hidden Function",
        "dropDownMenuItems": "test",
        "configKey" : "test"

      },

      "2": {"title": "Output Function",
        "dropDownMenuItems": "test",
        "configKey" : "test"
      },

      "3": {"title": "concatenation",
        "dropDownMenuItems": "test",
        "configKey" : "test"
      }

    };
    return Container(
      color: Colors.blue.withOpacity(0.4),
      child: Center(
        // Convert this to the on the fly builder ?
        // Entirely remove the pre built cards
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index){
            var data = dataSet[index.toString()];
            List<String> menuItems = data!["dropDownMenuItems"]!.split(",");
            String configKey = data!["configKey"]!;
            return Card(
              child: Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data!["title"]!),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomDropDownMenu(updateConfigData, menuItems, configKey),
                  )

                ]
              ),
            );
          },
        ),
      )



    );


  }

  }