import 'package:flutter/material.dart';
import 'package:ann_app/widgets/navigation_widgets/animation_selection_custom_card.dart';

class AnimationSelectionUIHero extends StatefulWidget{
  const AnimationSelectionUIHero({super.key, required this.runAnimationCallBack, required this.payloadData, required this.heroTag});

  final Function(List<int>) runAnimationCallBack;
  final List<List> payloadData;
  final String heroTag;

  @override
  State<AnimationSelectionUIHero> createState() => _AnimationSelectionUIHero();

}

class _AnimationSelectionUIHero extends State<AnimationSelectionUIHero>{

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 400, 0, 60),
      child: SingleChildScrollView(
        child:
        Hero(
            tag: widget.heroTag,
            child: SizedBox(
              height: 380,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:    [
                    const SizedBox(
                        height: 30,
                        child: Material(
                            color: Colors.transparent,

                            child:  Text("Scroll to see each generation", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),))
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: SizedBox(
                          height: 240,
                          width: MediaQuery.of(context).size.height,
                          child: CustomScrollView(
                              scrollDirection: Axis.horizontal,
                              slivers: [
                                SliverList(
                                    delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                                      return GenerationDataCard(
                                        index: index,
                                        payloadData: widget.payloadData[index],
                                        runAnimationCallBack: (animationPath){
                                          widget.runAnimationCallBack(animationPath);
                                        },) ;
                                    },
                                        childCount: widget.payloadData.length
                                    )
                                )
                              ]
                          ),
                        ),
                      ),
                    )
                  ]
              ),
            )
        ),

      ),
    );
  }
}