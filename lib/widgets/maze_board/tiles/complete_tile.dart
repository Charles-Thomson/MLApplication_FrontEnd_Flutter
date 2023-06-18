import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/tiles/tile_top.dart';
import 'package:ann_app/widgets/maze_board/tiles/tile_body_painter.dart';
import 'package:ann_app/widgets/maze_board/tiles/tile_config.dart' as tile_config;
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;


class NewCompleteTile extends StatefulWidget{
   NewCompleteTile({super.key,
    required this.updateTileDataCallBack,
    required this.tileIndex,
    });

  final int Function(int, int) updateTileDataCallBack;
  final double tileHeight = maze_config.tileHeight;
  final double tileWidth = maze_config.tileWidth;
  final int tileIndex;

@override
  State<NewCompleteTile> createState() => _NewCompleteTile();
}

class _NewCompleteTile extends State<NewCompleteTile>{
  tile_config.Tile currentTileConfig = tile_config.OpenTile();
  List<tile_config.Tile> tileConfigs = [
    tile_config.OpenTile(), // Padding at the start due to open tile = 1 on backend.
    tile_config.StartTile(),
    tile_config.ObstacleTile(),
    tile_config.GoalTile()];

  @override
  Widget build(BuildContext context){
    int tileStateValue = 0;
    double tileOffSet = currentTileConfig.getTileOffSet;
    double depth = currentTileConfig.getDepth;
    Color primaryColor = currentTileConfig.getPrimaryColor;

    void checkForRedraw(int newTileStateVale) {
      setState(() {
        currentTileConfig = tileConfigs[newTileStateVale];
        tileStateValue++;
      });
    }

    return Transform.translate(
      offset: Offset(tileOffSet, tileOffSet),
      child: SizedBox(
          height: widget.tileHeight,
          width: widget.tileWidth,
          child: Stack(
              children: [
          CustomPaint(
          size: Size(widget.tileHeight, widget.tileWidth),
          painter: TilePainter(tileState: tileStateValue, depth: depth)
          ),
                TileTop(
                  updateTileDataCallBack: (index,tileState) {
                    int newTileState = widget.updateTileDataCallBack(index, tileState);
                    checkForRedraw(newTileState); // In current widget
                    return newTileState; // -> tile_top
                  },

                  tileIndex: widget.tileIndex,
                  primaryColor: primaryColor,
                )
              ]
          )
      ),
    );
  }
}
