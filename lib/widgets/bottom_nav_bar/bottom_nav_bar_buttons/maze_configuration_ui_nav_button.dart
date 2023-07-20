import 'package:flutter/material.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/hero_route.dart';

import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/maze_configuration_ui_hero_page.dart';

class MazeConfigurationUIButton extends StatelessWidget{
  const MazeConfigurationUIButton({super.key, required this.updateMazeMap});
  final Function(Map<String, String>) updateMazeMap;

  static const String _mazeConfigurationHeroTag = "maze-configuration-ui-pop-out";

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return MapConfigurationUIHero(updateMazeMap: updateMazeMap, heroTag: _mazeConfigurationHeroTag);
            }
            )
            );
          },
          child: Hero(
              tag: _mazeConfigurationHeroTag,
              child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child:  Icon(
                      Icons.map_outlined,
                      size: 40,
                      color: Theme.of(context).primaryColor
                  )
              )
          ),
        )
    );
  }
}