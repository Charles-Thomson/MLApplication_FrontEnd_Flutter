import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze_body/body_painter.dart';
import 'package:ann_app/widgets/maze_board/tiles/tile_grid.dart';
import 'package:ann_app/widgets/maze_board/maze_body/rim_painter.dart';
import 'package:ann_app/widgets/animation//animation_main.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as config;


class BuiltMaze extends StatelessWidget{
  const BuiltMaze({super.key, required this.updateTileDataCallBack, required this.animationVisible, required this.agentAnimationLocation, required this.tileData});

  final int Function(int, int) updateTileDataCallBack;
  final bool animationVisible;
  final int agentAnimationLocation;
  final List<int> tileData;



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
            painter: BodyPainter(context: context)
          ),
         Positioned(
         child: RimContainer()
         ),
         Positioned(
            bottom: config.rimOffSet / 2,
            right: config.rimOffSet / 2,
            child: RimContainerCutout()
        ),
          Positioned(
            bottom: config.rimOffSet   ,
            right: config.rimOffSet ,
            child: Stack( children: [
              TileGrid(
                // push the current Tile data in here
              updateTileDataCallBack: (index, tileState){
              int newTileState = updateTileDataCallBack(index, tileState);
                return newTileState;
                },
                tileData: tileData
              ),
               Visibility(
                visible: animationVisible,
                  child: AgentAnimation(agentAnimationLocation: agentAnimationLocation)),
              ]
            )
          )]
        ),
      ),
    );
  }
}