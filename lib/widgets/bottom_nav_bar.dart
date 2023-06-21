import 'package:ann_app/widgets/function_selection_widgets/bottom_nav_function_settings.dart';
import 'package:ann_app/widgets/parameter_selection_widgets/parameter_selection_nav_bar_button.dart';
import 'package:ann_app/widgets/maze_selection_widgets/bottom_nav_bar_maze_button.dart';
import 'package:flutter/material.dart';



class CustomBottomNavBar extends StatefulWidget{
  const CustomBottomNavBar( this.dockedLocation, {super.key,required this.updateConfigData,required this.updateMazeMap});

  final FloatingActionButtonLocation dockedLocation;
  final Function(String, String) updateConfigData;
  final Function(Map<String, String>) updateMazeMap;

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
      MazeSettingsButton(updateMazeMap: (newMapData){
        widget.updateMazeMap(newMapData);
      }),
      ParameterSettingsButton(updateConfigData: (configKey, newValue){
        widget.updateConfigData(configKey, newValue);
      }),
      FunctionSettingsButton(updateConfigData: (configKey, newValue){
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

