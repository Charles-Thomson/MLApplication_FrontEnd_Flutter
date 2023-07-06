import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;


class TileTop extends StatefulWidget{
    const TileTop({super.key,
    required this.updateTileDataCallBack,// this is the callback to top level
    required this.tileIndex,
    required this.primaryColor,
      required this.tileState

  });

  final int Function(int, int) updateTileDataCallBack;
  final int tileIndex;
  final Color primaryColor;
  final int tileState;

  @override
  State<TileTop> createState() => _TileTop();
}
class _TileTop extends State<TileTop>{
  get tileIndex => widget.tileIndex;
  get primaryColor => widget.primaryColor;

  @override
  Widget build(BuildContext context){
    int tileState = widget.tileState;
    return  InkWell(
        onTap: () {
          int newTileState = widget.updateTileDataCallBack.call(tileIndex, tileState) ;
          setState(() {
            tileState = newTileState ;
          });
          },

        child: Container(
            height: maze_config.tileSize,
            width: maze_config.tileSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: RadialGradient(
                  colors: <Color>[
                    primaryColor.shade300,
                    primaryColor.shade400,
                    primaryColor.shade500,
                    primaryColor.shade600,
                  ],
                ),
                boxShadow: [BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                    blurStyle: BlurStyle.solid
                )
                ]
            ),
            child: Center(
                child: Text(tileIndex.toString())
            )
        )
        );
  }
}