import 'package:flutter/material.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/hero_route.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar_hero_pages/animation_selection_ui_hero_page.dart';

class AnimationSelectionUIButton extends StatelessWidget{
  const AnimationSelectionUIButton({super.key, required this.runAnimationCallBack, required this.payloadData});
  final Function(List<int>) runAnimationCallBack;
  final List<List> payloadData;

  static const String _animationSelectionHeroTag = "generation-data-pop-out";
  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return AnimationSelectionUIHero(
                payloadData: payloadData,
                runAnimationCallBack: (animationPath){
                  runAnimationCallBack(animationPath);
                },
              heroTag: _animationSelectionHeroTag
              );
            }
            )
            );
          },

          child: Hero(
              tag: _animationSelectionHeroTag,
              child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child: Icon(
                      Icons.data_thresholding_outlined,
                      size: 40,
                      color: Theme.of(context).primaryColor
                  )
              )
          ),
        )
    );
  }
}