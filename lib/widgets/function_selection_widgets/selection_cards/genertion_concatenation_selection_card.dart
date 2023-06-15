import 'package:flutter/material.dart';
import 'package:ann_app/widgets/dropdownselector.dart';

class ConcatenationCard extends StatelessWidget{
  ConcatenationCard({super.key, required this.updateConfigData});

  final Function(String, String) updateConfigData;
  final  menuItems = ["Generation concatenation","Merging", "Avg"];
  final String configKey = "WEIGHTS_CONCATENATION_FUNCTIONS";

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
                        ,"ConcatenationCard"),
                  )
              ),
              const SizedBox(
                  height: 10
              ),
              SizedBox(
                height: 100,
                width: 300,
                child: DropDownMenu(updateConfigData, menuItems, configKey)
              )
            ]
        )
    );
  }
}