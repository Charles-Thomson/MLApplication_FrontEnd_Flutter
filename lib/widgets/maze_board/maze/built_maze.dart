import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze_walls/body_painter.dart';
import 'package:ann_app/widgets/tiles/tile_grid.dart';
import 'package:ann_app/widgets/maze_board/maze_walls/rim_painter.dart';

double mazeHeight = 200;
double mazeWidth = 200 ;
double edgeRadius = 20;
double rimOffSet = 30;

class BuiltMaze extends StatelessWidget{
  const BuiltMaze({super.key, required this.updateTileData_CallBack});

  final int Function(int, int) updateTileData_CallBack;
  @override
  Widget build(BuildContext context){
    return Transform.rotate(
      angle: 0.8,
      child: SizedBox(
        height: mazeHeight,
        width: mazeWidth,
        child: Stack(
          children:  [
          CustomPaint(
            size: Size(mazeHeight,mazeWidth),
            painter: BodyPainter(edgeRadius: edgeRadius)
          ),
         Positioned(
             child:  RimContainer(mazeHeight: mazeHeight, mazeWidth: mazeWidth, edgeRadius: edgeRadius)
         ),
         Positioned(
            bottom: rimOffSet / 2,
            right: rimOffSet / 2,
            child: RimContainerCutout(mazeHeight: mazeHeight, mazeWidth: mazeWidth, rimOffSet: rimOffSet)
        ),
          Positioned(
            bottom: rimOffSet   ,
            right: rimOffSet ,
            child: TileGrid(
                updateTileData_CallBack: (index, tileState){
                  int newTileState = updateTileData_CallBack(index, tileState);
                  return newTileState;
                }
            ),
          ),
      ]
    ),
  ),
  );
  }
}