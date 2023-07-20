import 'package:flutter/material.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/hero_route.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/function_selection_ui_hero_page.dart';


class FunctionSelectionUIButton extends StatelessWidget{
  const FunctionSelectionUIButton({super.key, required this.updateConfigData});
  final Function(String, String) updateConfigData;

  static const String _functionSelectionHeroTag = "functions-pop-out";

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return FunctionSelectionUIHero(updateConfigData: updateConfigData, heroTag: _functionSelectionHeroTag);
            }
            )
            );
          },

          child: Hero(
              tag: _functionSelectionHeroTag,
              child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child:  Icon(
                    Icons.functions,
                    size: 40,
                    color: Theme.of(context).primaryColor,

                  )
              )
          ),
        )
    );
  }
}