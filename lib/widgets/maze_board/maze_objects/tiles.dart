import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TileGrid extends StatelessWidget{
  const TileGrid({super.key});
  final int mapSize = 4;
  final double tileHeight = 40;
  final double tileWidth = 40;
  final double tileOffSet = 5;
  final Color primaryColor = Colors.grey;


  @override
  Widget build(BuildContext context){
    List fullTileIndex = List.generate(16, (index) => 0); // +1 as it's a loop
    Color thisUsedColor = primaryColor;

    // adding to the list at the index relating to the tile index
    int addToListFunction(int index, var tileStatus){

      fullTileIndex[index] += 1;
      print("The current list of index's:  $fullTileIndex ");
      int returnVal = fullTileIndex[index];
      return returnVal;
    }

    void setNewColor(int index){
      int stateValue = fullTileIndex[index];
      if (stateValue == 2){
        thisUsedColor = Colors.blue;
        print("Changed to blue");
    }else{
      thisUsedColor = Colors.blue;
    }
    }

    List <Widget>tileList = List.generate(mapSize * mapSize,
            (index){
          return CompleteTile(
            // These values correspond to the receiving func(val, val)
            key: UniqueKey(),

            callback: (index, tileStateValue) {
              int returnVal = addToListFunction(index,tileStateValue);
              setNewColor(index);

              return returnVal;
            },

            tileState: fullTileIndex[index],
            tileHeight: tileHeight,
            tileWidth: tileWidth,
            tileOffSet: tileOffSet,
            tileIndex: index,
            primaryColor: thisUsedColor,
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

class CompleteTile extends StatelessWidget{
  const CompleteTile({required Key key,
    required this.tileState,
    required this.callback,
    required this.tileHeight,
    required this.tileWidth,
    required this.tileOffSet,
    required this.tileIndex,
    required this.primaryColor}): super(key: key);

  final int tileState;
  final int Function(int, int) callback;
  final double tileHeight;
  final double tileWidth;
  final double tileOffSet;
  final int tileIndex;
  final Color primaryColor;

  @override
  Widget build(BuildContext context){

    double offSetX = 2;
    double offSetY = 2;
    Color usedColor = primaryColor;

    if (tileState == 2){
      usedColor = Colors.red;
      offSetX = 10;
      offSetY = 10;
    }
    if (tileState == 1){
      usedColor = Colors.blue;
    }

    return Transform.translate(
      offset: Offset(offSetX, offSetY),
      child: SizedBox(
        height: tileHeight,
        width: tileWidth,

        child: Stack(
          children: [
              CustomPaint(
                  size: Size(tileHeight, tileWidth),
                  painter: TilePainter(tileState: tileState)
              ),

              TileTop(
                  myOnPressed: (index,tileStateValue) {
                    int returnVal = callback(index, tileStateValue);
                    return returnVal;
                  },
                  tileHeight: tileHeight,
                  tileWidth: tileWidth,
                  tileOffSet: tileOffSet,
                  tileIndex: tileIndex,
                  primaryColor: primaryColor,
                  )
          ]
        )
      ),
    );
  }
}

class TileTop extends StatefulWidget{

  const TileTop({super.key,
    required this.myOnPressed,// this is the callback to top level
    required this.tileHeight,
    required this.tileWidth,
    required this.tileOffSet,
    required this.tileIndex,
    required this.primaryColor,
    });

  final int Function(int, int) myOnPressed;
  final double tileHeight;
  final double tileWidth;
  final double tileOffSet;
  final int tileIndex;
  final Color primaryColor;


  @override
  State<TileTop> createState() => _TileTop();
}
class _TileTop extends State<TileTop>{
  int tileStateValue = 0;
  late Color localPrimaryColor;

  // Color thiPrimaryColor = Colors.blueGrey;

  get primaryColor => localPrimaryColor;
  get tileIndex => widget.tileIndex;
  // set newPrimaryColor(Color newColor){
  //   thiPrimaryColor = newColor;
  // }

  @override
  void initState(){
    localPrimaryColor = widget.primaryColor;
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    return  InkWell(
      onTap: () {
        // incrementState();
        int newTileStateValue = widget.myOnPressed.call(tileIndex, tileStateValue) ;

        setState(() {
          tileStateValue = newTileStateValue ;

        });
        print("tapped on container $tileIndex: State: $tileStateValue");},

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
      ),
    );
  }
}

class TilePainter extends CustomPainter{
  TilePainter({required this.tileState});

  final double edgeRadius = 2;
  final int tileState;

  final tilePaint = Paint();
  double depth = 8; // normally 20

  @override
  void paint(Canvas canvas, Size size){
    if (tileState == 2){
      depth = 0;
    }
    tilePaint.shader = ui.Gradient.linear(const Offset(0, 20), const Offset(20, 0), [
      Colors.blueGrey.shade700,
      Colors.blueGrey.shade500,
      Colors.blueGrey.shade300,
      Colors.blueGrey.shade200,
      Colors.blueGrey.shade100,
      Colors.blueGrey.shade700,
    ],
      [0.01, 0.2, 0.49, 0.52, 0.6, 0.8],);
    double radiosOffset = edgeRadius;
    double borderRadiusOffset =
        (radiosOffset * math.sqrt(2) - radiosOffset) / math.sqrt(2);
    //double distance = 10;
    final tilePath = Path()
     ..addRRect(RRect.fromRectAndRadius(
         Rect.fromLTWH(0, 0, size.width, size.height),
         Radius.circular(edgeRadius))
     )
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(depth, depth, size.width, size.height),
          Radius.circular(edgeRadius))
      )
      ..moveTo(size.width - borderRadiusOffset, borderRadiusOffset)
      ..lineTo(
        size.width + depth - borderRadiusOffset,
        depth + borderRadiusOffset,
      )
      ..lineTo(
        depth + borderRadiusOffset,
        size.height + depth - borderRadiusOffset,
      )
      ..lineTo(borderRadiusOffset, size.height- borderRadiusOffset);

    canvas.drawShadow(
      tilePath,
      Colors.black,
      5,
      false,
    );
    canvas.translate(1.1,1.1);
    canvas.scale(1.05, 1.05); // 1.05 normally
    canvas.drawPath(tilePath, tilePaint);
  }

  @override
  bool shouldRepaint(TilePainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(TilePainter oldDelegate) => false;
}