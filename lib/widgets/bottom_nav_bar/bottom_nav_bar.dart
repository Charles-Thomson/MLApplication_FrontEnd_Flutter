import 'package:flutter/material.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_buttons/graph_ui_nav_button.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_buttons/function_selection_ui_nav_button.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_buttons/hyper_parameter_selection_ui_nav_button.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_buttons/maze_configuration_ui_nav_button.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_buttons/animation_selection_ui_nav_button.dart';

class CustomBottomNavBar extends StatefulWidget{
  const CustomBottomNavBar({super.key,required this.buttonState,required this.updateConfigData,required this.updateMazeMap, required this.runAnimationCallBack, required this.payloadData});


  final Function(String, String) updateConfigData;
  final Function(Map<String, String>) updateMazeMap;
  final Function(List<int>) runAnimationCallBack;

  final int buttonState;
  final List<List> payloadData;



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

         MazeConfigurationUIButton(updateMazeMap: (newMapData){
           widget.updateMazeMap(newMapData);
         }),
         HyperParameterSettingsUIButton(updateConfigData: (configKey, newValue){
           widget.updateConfigData(configKey, newValue);
         }),
         FunctionSelectionUIButton(updateConfigData: (configKey, newValue){
           widget.updateConfigData(configKey, newValue);
         }),

       ];
     case 1:
       return [
         AnimationSelectionUIButton(runAnimationCallBack: (animationPath){
           widget.runAnimationCallBack(animationPath);
         },
         payloadData: widget.payloadData
         ),

         GraphUIButton(
             payloadData: widget.payloadData
         ),
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

