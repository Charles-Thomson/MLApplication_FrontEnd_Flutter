import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/tiles/complete_tile.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as config;


class TileGrid extends StatelessWidget{
  const TileGrid({super.key, required this.updateTileDataCallBack, required this.tileData});

  final Function(int,int) updateTileDataCallBack;
  final List<int> tileData;

  @override
  Widget build(BuildContext context){
    List <Widget>tileList = List.generate(tileData.length,
            (index){
          return NewCompleteTile(
            key: UniqueKey(),

            updateTileDataCallBack: (index, tileState) {
              int newTileState = updateTileDataCallBack(index,tileState);
              return newTileState;
            },
            tileIndex: index,
            tileStateValue: tileData[index],
          );
        }
    );

    return SizedBox(
      // this size subtraction is needed - addition somewhere ....
      height: config.tileGridHeight - 2,
      width: config.tileGridWidth - 2,
      child: GridView.count(
          crossAxisCount: config.totalYStates,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: tileList
      ),
    );
  }
}