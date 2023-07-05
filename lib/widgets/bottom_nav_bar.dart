
import 'package:ann_app/widgets/function_selection_widgets/bottom_nav_function_settings.dart';
import 'package:ann_app/widgets/parameter_selection_widgets/parameter_selection_nav_bar_button.dart';
import 'package:ann_app/widgets/maze_selection_widgets/bottom_nav_bar_maze_button.dart';

import 'package:ann_app/widgets/generation_data_widgets/generation_data_nav_button.dart';
import 'package:ann_app/widgets/full_data_nav_bar/full_data_nav_bar.dart';

import 'package:flutter/material.dart';


class CustomBottomNavBar extends StatefulWidget{
  const CustomBottomNavBar({super.key,required this.buttonState,required this.updateConfigData,required this.updateMazeMap, required this.runAnimationCallBack});


  final Function(String, String) updateConfigData;
  final Function(Map<String, String>) updateMazeMap;
  final int buttonState;

  final Function(List<int>) runAnimationCallBack;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBar();
}

class _CustomBottomNavBar extends State<CustomBottomNavBar>{
  final NotchedShape? thisShape = const CircularNotchedRectangle();


  Widget placeHolder = Opacity(opacity: 0.0,
      child: IconButton(onPressed: () {},
          icon: const Icon(Icons.abc)));

  List<Widget> buildButtonSet(){
   switch(widget.buttonState){
     case 0:
       return [

         MazeSettingsButton(updateMazeMap: (newMapData){
           widget.updateMazeMap(newMapData);
         }),
         placeHolder,
         placeHolder,
         ParameterSettingsButton(updateConfigData: (configKey, newValue){
           widget.updateConfigData(configKey, newValue);
         }),
         FunctionSettingsButton(updateConfigData: (configKey, newValue){
           widget.updateConfigData(configKey, newValue);
         }),

       ];
     case 1:
       return [
         GenerationDataButton(runAnimationCallBack: (animationPath){
           widget.runAnimationCallBack(animationPath);
         }

         ),
         const FullDataButton(),
         placeHolder,
       ];
   }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> currentNavBarButtonSet = buildButtonSet();
    return BottomAppBar(
      height: 60,
      shape: const CircularNotchedRectangle(),
      color: Colors.blueGrey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          ...currentNavBarButtonSet
          //HeuristicSelectionButton()
        ]
      )
    );
  }
}

