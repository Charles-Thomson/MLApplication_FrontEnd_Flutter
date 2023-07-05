import 'package:flutter/material.dart';
import 'package:ann_app/widgets/hero_route.dart';
import 'package:ann_app/widgets/generation_data_widgets/custom_generation_data_card.dart';

import 'package:ann_app/widgets/full_data_nav_bar/graph_data_processing.dart';
import 'package:ann_app/widgets/full_data_nav_bar/graph_test_data.dart';

const String _generationdatapopouttag = "generation-data-pop-out";

class GenerationDataButton extends StatelessWidget{
  const GenerationDataButton({super.key, required this.runAnimationCallBack});
  final Function(List<int>) runAnimationCallBack;
  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return GenerationDataPopOut(
                runAnimationCallBack: (animationPath){
                runAnimationCallBack(animationPath);
              },);
            }
            )
            );
          },

          child: Hero(
              tag: _generationdatapopouttag,
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

class GenerationDataPopOut extends StatefulWidget{
  const GenerationDataPopOut({super.key, required this.runAnimationCallBack});

  final Function(List<int>) runAnimationCallBack;

  @override
  State<GenerationDataPopOut> createState() => _GenerationDataPopOut();

}

class _GenerationDataPopOut extends State<GenerationDataPopOut>{
  var testData = jsonGraphTestData;
  generationData(generationNumber) => getGenerationData(testData, generationNumber);
  int get numberOfGenerations => getNumberOfGenerations(testData);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Hero(
                tag: _generationdatapopouttag,
                child: Container(
                    color: Colors.transparent,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                        children:    [
                           const SizedBox(
                             height: 30,
                             child: Material(
                                 color: Colors.transparent,
                                 child: Text("Scroll to see each generation", style: TextStyle(fontSize: 18),))
                           ),
                           Padding(
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
                                          generationData: generationData(index),
                                          runAnimationCallBack: (animationPath){
                                            widget.runAnimationCallBack(animationPath);

                                        },) ;
                                      },
                                      childCount: numberOfGenerations
                                      )

                                  )

                                ]



                          ),
                             ),
                           )
                        ]
                    ))
            ),
          ],
        ),
      ),
    );
  }
}


