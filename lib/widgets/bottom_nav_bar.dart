import 'package:flutter/material.dart';

import 'package:ann_app/widgets/nav_bar_buttons/bottom_nav_button_activation.dart';
import 'package:ann_app/widgets/nav_bar_buttons/bottom_nav_button_weight_heuristic.dart';
import 'package:ann_app/widgets/nav_bar_buttons/bottom_nav_button_generation_concaternation.dart';

class CustomBottomNavBar extends StatefulWidget{
  const CustomBottomNavBar(this.dockedLocation,{super.key, required this.updateWeightHeuristic});

  final FloatingActionButtonLocation dockedLocation;
  final Function(String) updateWeightHeuristic;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBar();
}

class _CustomBottomNavBar extends State<CustomBottomNavBar>{
  final NotchedShape? thisShape = const CircularNotchedRectangle();
  List<Icon> frontDockedIcons = const [Icon(Icons.abc),Icon(Icons.abc),Icon(Icons.abc)];
  List<Icon> endDockedIcons = const [Icon(Icons.abc),Icon(Icons.map),Icon(Icons.time_to_leave)];

  get getFrontDockedIcons => frontDockedIcons;
  get getEndDockedIcons => endDockedIcons;

  get dockedLocation => widget.dockedLocation;

  @override
  Widget build(BuildContext context) {
    Widget placeHolder = Opacity(opacity: 0.0,
        child: IconButton(onPressed: () {},
            icon: const Icon(Icons.abc)));


    List<Widget> builtNavBarItems =  [
      placeHolder,
      WeightHeuristicNavButton(updateWeightHeuristic: (newWeightHeuristic){
      widget.updateWeightHeuristic(newWeightHeuristic);
      }),
      const ActivationNavButton(),
      const GenerationNavButton()
    ];
    //builtNavBarItems = [];
    //buildNavBar(dockedLocation);

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


      // This needs to be cleaned up
      // Build statically then display is the other option , will be easier on the
      // onPress handling ?
      // List<Widget> buildNavBar(dockedLocation){
      //   List<Widget> navBarItems = [];
      //   Widget placeHolder = Opacity(opacity: 0.0,
      //                               child: IconButton(onPressed: () {},
      //                               icon: const Icon(Icons.abc)));
      //
      //   if(dockedLocation == FloatingActionButtonLocation.startDocked){
      //     List<Widget> items = [];
      //     for(Icon thisIcon in frontDockedIcons){
      //       Widget item = buildNavItem(thisIcon: thisIcon);
      //       items.add(item);
      //     }
      //     navBarItems = items;
      //     navBarItems.insert(0,placeHolder);
      //
      //   } else if(dockedLocation == FloatingActionButtonLocation.endDocked){
      //     List<Widget> items = [];
      //     for(Icon thisIcon in endDockedIcons){
      //       Widget item = buildNavItem(thisIcon: thisIcon);
      //       items.add(item);
      //     }
      //     navBarItems = items;
      //     navBarItems.add(placeHolder);
      //   }
      //     return navBarItems;
      // }
      //
      // Widget buildNavItem({required Icon thisIcon}){
      //     Widget thisButton = IconButton(onPressed: () {}, icon: thisIcon);
      //     return thisButton;
      // }


}

