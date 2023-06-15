import 'package:flutter/material.dart';
import 'package:ann_app/widgets/tiles/complete_tile.dart';


class TileGrid extends StatelessWidget{
  const TileGrid({super.key, required this.updateTileData_CallBack});

  final Function(int,int) updateTileData_CallBack;
  final int mapSize = 4;
  final double tileHeight = 40;
  final double tileWidth = 40;

  @override
  Widget build(BuildContext context){

    List <Widget>tileList = List.generate(mapSize * mapSize,
            (index){
          return NewCompleteTile(
            // These values correspond to the receiving func(val, val)
            key: UniqueKey(),

            updateTileData_CallBack: (index, tileState) {
              int newTileState = updateTileData_CallBack(index,tileState);
              return newTileState;
            },
            tileHeight: tileHeight,
            tileWidth: tileWidth,
            tileIndex: index,
          );
        }
    );

    return SizedBox(
      height: 160,
      width: 160,
      child: GridView.count(
          crossAxisCount: mapSize,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,

          children: tileList
      ),
    );
  }
}