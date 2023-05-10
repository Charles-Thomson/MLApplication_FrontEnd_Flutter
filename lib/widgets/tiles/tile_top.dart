import 'package:flutter/material.dart';


class TileTop extends StatefulWidget{

  const TileTop({super.key,
    required this.myOnPressed,// this is the callback to top level
    required this.tileHeight,
    required this.tileWidth,
    required this.tileIndex,
    required this.primaryColor,
  });

  final int Function(int, int) myOnPressed;
  final double tileHeight;
  final double tileWidth;
  final int tileIndex;
  final Color primaryColor;


  @override
  State<TileTop> createState() => _TileTop();
}
class _TileTop extends State<TileTop>{
  int tileStateValue = 0;
  get tileIndex => widget.tileIndex;
  get primaryColor => widget.primaryColor;



  @override
  Widget build(BuildContext context){
    return  InkWell(
        onTap: () {
          int newTileStateValue = widget.myOnPressed.call(tileIndex, tileStateValue) ;
          // does this need to be tracked down on the widget level ?
          setState(() {
            tileStateValue = newTileStateValue ;
          });
          },

        child: Container(
            height: widget.tileHeight,
            width: widget.tileWidth,
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