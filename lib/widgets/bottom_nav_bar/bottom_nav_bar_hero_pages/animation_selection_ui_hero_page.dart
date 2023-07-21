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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, kBottomNavigationBarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              child:
              Hero(
                  tag: widget.heroTag,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:    [
                          const Expanded(
                            child: Material(
                                color: Colors.transparent,
                                child:  Text("Scroll to see each generation", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                          ),
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: CustomScrollView(
                                  scrollDirection: Axis.vertical,
                                  slivers: [
                                    SliverList(
                                        delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                                          return GenerationDataCard(
                                            index: index,
                                            payloadData: widget.payloadData[index],
                                            runAnimationCallBack: (animationPath){
                                              widget.runAnimationCallBack(animationPath);
                                            },
                                          ) ;
                                        },
                                            childCount: widget.payloadData.length
                                        )
                                    )
                                  ]
                              ),
                            ),
                          )
                        ]
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}