import 'package:flutter/material.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/hero_route.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/hyper_parameter_ui_hero_page.dart';


class HyperParameterSettingsUIButton extends StatelessWidget{
  const HyperParameterSettingsUIButton({super.key, required this.updateConfigData});
  final Function(String, String) updateConfigData;

  static const String _hyperParameterUIHeroTag = "hyper-parameter-ui-pop-out";

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return HyperParameterSelectionUIHero(updateConfigData: updateConfigData, heroTag: _hyperParameterUIHeroTag);
            }
            )
            );
          },

          child: Hero(
              tag: _hyperParameterUIHeroTag,
              child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child:  Icon(
                      Icons.data_object,
                      size: 40,
                      color: Theme.of(context).primaryColor
                  )
              )
          ),
        )
    );
  }
}