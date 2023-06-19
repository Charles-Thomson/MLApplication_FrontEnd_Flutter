import 'package:flutter/material.dart';
import 'package:ann_app/widgets/dropdownselector.dart';

class OutputActivationCard extends StatelessWidget{
  OutputActivationCard({super.key, required this.updateConfigData});

  final Function(String, String) updateConfigData;
  final  menuItems = ["Output Activation Function", "Arg max", "Soft max"];
  final String configKey = "OUTPUT_LAYER_ACTIVATION_FUNCTION";

  @override
  Widget build(BuildContext context){
    return Container(

        color: Colors.white,
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:    [
              const SizedBox(
                  height: 40,
                  child: Material(
                    child: Text(
                        style: TextStyle(fontSize: 20)
                        ,"OutputActivation Card"),
                  )
              ),
              const SizedBox(
                  height: 10
              ),
              SizedBox(
                  height: 100,
                  width: 300,
                  child: CustomDropDownMenu(updateConfigData, menuItems, configKey)
              )
            ]
        )
    );
  }
}