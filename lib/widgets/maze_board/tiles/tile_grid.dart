import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/tiles/complete_tile.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as config;


class TileGrid extends StatelessWidget{
  TileGrid({super.key, required this.updateTileDataCallBack});

  final Function(int,int) updateTileDataCallBack;
  final int mapSize = config.mapSize;

  @override
  Widget build(BuildContext context){

    List <Widget>tileList = List.generate(config.mapSizeX * config.mapSizeY,
            (index){
          return NewCompleteTile(
            // These values correspond to the receiving func(val, val)
            key: UniqueKey(),

            updateTileDataCallBack: (index, tileState) {
              int newTileState = updateTileDataCallBack(index,tileState);
              return newTileState;
            },
            tileIndex: index,
          );
        }
    );

    return SizedBox(
      height: config.tileGridHeight,
      width: config.tileGridWidth,
      child: GridView.count(
          crossAxisCount: config.mapSizeY, // WORING FROM HERE !!
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: tileList
      ),
    );
  }
}