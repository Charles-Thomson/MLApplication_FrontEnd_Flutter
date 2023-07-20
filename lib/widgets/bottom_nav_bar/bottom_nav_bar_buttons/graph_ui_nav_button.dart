import 'package:flutter/material.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/hero_route.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/graph_ui_hero_page.dart';

class GraphUIButton extends StatelessWidget{
  const GraphUIButton({super.key, required this.payloadData});
  final List<List> payloadData;

  static const String _graphUIHeroTag = "graph-UI-pop-out";

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return GraphUIHero(payloadData: payloadData, heroTag: _graphUIHeroTag);
            }
            )
            );
          },

          child: Hero(
              tag: _graphUIHeroTag,
              child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child: Icon(
                      Icons.animation_sharp,
                      size: 40,
                      color: Theme.of(context).primaryColor
                  )
              )
          ),
        )
    );
  }
}