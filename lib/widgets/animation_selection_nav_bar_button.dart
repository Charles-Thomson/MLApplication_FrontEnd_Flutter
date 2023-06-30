import 'package:flutter/material.dart';
import 'package:ann_app/widgets/hero_route.dart';

const String _animationselectionpopouttag = "animation-selection-pop-out";

class AnimationSelectionButton extends StatelessWidget{
  const AnimationSelectionButton({super.key});
  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return const AnimationSelectionPopOut();
            }
            )
            );
          },

          child: Hero(
              tag: _animationselectionpopouttag,
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

class AnimationSelectionPopOut extends StatefulWidget{
  const AnimationSelectionPopOut({super.key});

  @override
  State<AnimationSelectionPopOut> createState() => _AnimationSelectionPopOut();

}

class _AnimationSelectionPopOut extends State<AnimationSelectionPopOut>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Hero(
              tag: _animationselectionpopouttag,
              child: Container(
                  height: 600,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueGrey.shade700,
                        Colors.blueGrey.shade500,
                        Colors.blueGrey.shade300,
                        Colors.blueGrey.shade300,
                        Colors.blueGrey.shade400,
                        Colors.blueGrey.shade700,
                      ],
                      stops: const [0.01, 0.1, 0.49, 0.51, 0.6, 1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    color: Colors.grey.withOpacity(0.6),
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                        blurStyle: BlurStyle.solid
                    )],
                  ),

                  child: Center(child:
                  Container(
                      height: 560,
                      width: 340,
                      color: Colors.white.withOpacity(0.7),
                      child:
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children:    [
                            SizedBox(
                                height: 40,
                                child: Material(
                                  color: Colors.white.withOpacity(0),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        style: TextStyle(fontSize: 20)
                                        ,"Animation Selection"),
                                  ),
                                )
                            ),
                          ]
                      )
                  )
                  ))
          )
      ),
    );
  }
}


