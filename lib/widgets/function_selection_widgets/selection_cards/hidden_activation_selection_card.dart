import 'package:flutter/material.dart';
import 'package:ann_app/widgets/dropdownselector.dart';

class HiddenActivationCard extends StatelessWidget{
  HiddenActivationCard({super.key, required this.updateConfigData});

  final Function(String, String) updateConfigData;
  final  menuItems = ["Hidden Activation Function", "Relu", "Leaky Relu", "Sigmoid", "Linear"];
  final String configKey = "HIDDEN_LAYER_ACTIVATION_FUNCTION";

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
                        ,"HiddenActivationCard"),
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