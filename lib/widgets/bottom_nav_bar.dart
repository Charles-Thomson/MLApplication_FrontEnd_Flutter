import 'package:flutter/material.dart';

import 'package:ann_app/widgets/nav_bar_buttons/bottom_nav_button_activation.dart';
import 'package:ann_app/widgets/nav_bar_buttons/bottom_nav_button_weight_heuristic.dart';
import 'package:ann_app/widgets/nav_bar_buttons/bottom_nav_button_generation_concaternation.dart';

class CustomBottomNavBar extends StatefulWidget{
  const CustomBottomNavBar( this.dockedLocation, {super.key,required this.updateConfigData});

  final FloatingActionButtonLocation dockedLocation;
  final Function(String, String) updateConfigData;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBar();
}

class _CustomBottomNavBar extends State<CustomBottomNavBar>{
  final NotchedShape? thisShape = const CircularNotchedRectangle();

  get dockedLocation => widget.dockedLocation;

  @override
  Widget build(BuildContext context) {
    Widget placeHolder = Opacity(opacity: 0.0,
        child: IconButton(onPressed: () {},
            icon: const Icon(Icons.abc)));


    List<Widget> builtNavBarItems =  [
      placeHolder,
      WeightHeuristicNavButton(updateConfigData: (configKey, newValue){
      widget.updateConfigData(configKey, newValue);
      }),
      ActivationNavButton(updateConfigData: (configKey, newValue){
        widget.updateConfigData(configKey, newValue);
      }),
      GenerationNavButton(updateConfigData: (configKey, newValue){
        widget.updateConfigData(configKey, newValue);
      }),
    ];

    return BottomAppBar(
      height: 60,
      shape: const CircularNotchedRectangle(),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          ...builtNavBarItems
          //HeuristicSelectionButton()
        ]
      )
    );
  }
}

