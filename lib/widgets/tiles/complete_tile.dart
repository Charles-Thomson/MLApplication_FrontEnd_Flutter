import 'package:flutter/material.dart';
import 'package:ann_app/widgets/tiles/tile_top.dart';
import 'package:ann_app/widgets/tiles/tile_body_painter.dart';
import 'package:ann_app/widgets/tiles/tile_config.dart' as config;


class NewCompleteTile extends StatefulWidget{
  const NewCompleteTile({super.key,
    required this.updateTileData_CallBack,
    required this.tileHeight,
    required this.tileWidth,
    required this.tileIndex,
    });

  final int Function(int, int) updateTileData_CallBack;
  final double tileHeight;
  final double tileWidth;
  final int tileIndex;

@override
  State<NewCompleteTile> createState() => _NewCompleteTile();
}

class _NewCompleteTile extends State<NewCompleteTile>{
  config.Tile currentTileConfig = config.OpenTile();
  List<config.Tile> tileConfigs = [config.OpenTile(), // Padding at the start due to open tile = 1 on backend.
                                  config.StartTile(),
                                   config.ObstacleTile(),
                                   config.GoalTile()];

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
                  updateTileData_CallBack: (index,tileState) {
                    int newTileState = widget.updateTileData_CallBack(index, tileState);
                    checkForRedraw(newTileState); // In current widget
                    return newTileState; // -> tile_top
                  },
                  tileHeight: widget.tileHeight,
                  tileWidth: widget.tileWidth,
                  tileIndex: widget.tileIndex,
                  primaryColor: primaryColor,
                )
              ]
          )
      ),
    );
  }
}
