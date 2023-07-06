import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/tiles/tile_top.dart';
import 'package:ann_app/widgets/maze_board/tiles/tile_body_painter.dart';
import 'package:ann_app/widgets/maze_board/tiles/tile_config.dart' as tile_config;
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;


class NewCompleteTile extends StatefulWidget{
   NewCompleteTile({super.key,
    required this.updateTileDataCallBack,
    required this.tileIndex,
     required this.tileStateValue,
    });

  final int Function(int, int) updateTileDataCallBack;
  final int tileStateValue;
  final double tileSize = maze_config.tileSize;

  final int tileIndex;

@override
  State<NewCompleteTile> createState() => _NewCompleteTile();
}

class _NewCompleteTile extends State<NewCompleteTile>{

  late tile_config.Tile currentTileConfig;

  @override
  void initState(){
    super.initState();
    currentTileConfig = tileConfigs[widget.tileStateValue]; // working to fix this
  }

  List<tile_config.Tile> tileConfigs = [
    tile_config.OpenTile(), // Padding at the start due to open tile = 1 on backend.
    tile_config.StartTile(),
    tile_config.ObstacleTile(),
    tile_config.GoalTile()];

  @override
  Widget build(BuildContext context){

    int tileStateValue = widget.tileStateValue;

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
          height: widget.tileSize,
          width: widget.tileSize,
          child: Stack(
              children: [
          CustomPaint(
          size: Size(widget.tileSize, widget.tileSize),
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
                  tileState: tileStateValue,
                )
              ]
          )
      ),
    );
  }
}
