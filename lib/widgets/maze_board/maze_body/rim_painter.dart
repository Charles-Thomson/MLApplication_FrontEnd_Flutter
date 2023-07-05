import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as config;

class RimContainer extends StatelessWidget{
  RimContainer({super.key});

    @override
    Widget build(BuildContext context){
      MaterialColor themePrimary = Theme.of(context).primaryColor as MaterialColor;
        return Container(
            // height: config.mazeHeight ,
            // width: config.mazeWidth ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(config.edgeRadius),
                gradient: LinearGradient(
                    colors: <Color>[
                      themePrimary.shade700,
                      themePrimary.shade500,
                      themePrimary.shade300,
                      themePrimary.shade600
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: const [0.01, 0.40, 0.50, 0.9],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 6,
                    offset: const Offset(1,1 ),
                    blurStyle: BlurStyle.solid
                  )
                ]
            )
            );
    }
}

class RimContainerCutout extends StatelessWidget{
  RimContainerCutout({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
        height: config.rimContainerCutOutHeight,
        width: config.rimContainerCutOutWidth,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  blurRadius: 1,
                  blurStyle: BlurStyle.solid
              )
            ]
        )
    );

  }
}

