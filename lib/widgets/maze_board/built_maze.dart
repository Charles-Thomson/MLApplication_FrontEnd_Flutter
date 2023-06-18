import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze_body/body_painter.dart';
import 'package:ann_app/widgets/maze_board/tiles/tile_grid.dart';
import 'package:ann_app/widgets/maze_board/maze_body/rim_painter.dart';
import 'package:ann_app/widgets/agent/agent_animation.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as config;


class BuiltMaze extends StatelessWidget{
  const BuiltMaze({super.key, required this.updateTileDataCallBack});

  final int Function(int, int) updateTileDataCallBack;

  final bool animationVisible = false;
  @override
  Widget build(BuildContext context){
    return Transform.rotate(
      angle: 0.8,
      child: SizedBox(
        height: config.mazeHeight,
        width: config.mazeWidth,
        child: Stack(
          children:  [

          CustomPaint(
            size: Size(config.mazeHeight,config.mazeWidth),
            painter: BodyPainter()
          ),
         const Positioned(
             child: RimContainer()
         ),
         Positioned(
            bottom: config.rimOffSet / 2,
            right: config.rimOffSet / 2,
            child: const RimContainerCutout()
        ),
          Positioned(
            bottom: config.rimOffSet   ,
            right: config.rimOffSet ,
            child: Stack( children: [
              TileGrid(
              updateTileDataCallBack: (index, tileState){
              int newTileState = updateTileDataCallBack(index, tileState);
                return newTileState;
                }
              ),
               Visibility(
                visible: animationVisible,
                  child:  const AgentAnimation()),
              ]
            )
          )]
        ),
      ),
    );
  }
}