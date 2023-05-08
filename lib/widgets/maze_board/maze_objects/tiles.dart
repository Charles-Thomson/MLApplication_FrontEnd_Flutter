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
    return SizedBox(
      height: 160,
      width: 160,
      child: GridView.count(
          crossAxisCount: mapSize,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: List.generate(mapSize * mapSize,
                  (index){
                  return CompleteTile(
                      tileHeight: tileHeight,
                      tileWidth: tileWidth,
                      tileOffSet: tileOffSet,
                      tileIndex: index,
                      primaryColor: primaryColor);
                  }
          ),
      ),
    );
  }
}

class CompleteTile extends StatelessWidget{
  const CompleteTile({super.key,
    required this.tileHeight,
    required this.tileWidth,
    required this.tileOffSet,
    required this.tileIndex,
    required this.primaryColor});

  final double tileHeight;
  final double tileWidth;
  final double tileOffSet;
  final int tileIndex;
  final Color primaryColor;


  @override
  Widget build(BuildContext context){
    bool unusedTile = false;
    double offSetX = 2;
    double offSetY = 2;
    Color usedColor = primaryColor;
    List<int> unusedTiles = [10,11,12,1,2];

    if (unusedTiles.contains(tileIndex)){
      usedColor = Colors.red;
      unusedTile = true;
      offSetX = 10;
      offSetY = 10;
    }
    CustomPainter painter = TilePainter(unusedTile: unusedTile);
    return Transform.translate(
      offset: Offset(offSetX, offSetY),
      child: SizedBox(
        height: tileHeight,
        width: tileWidth,

        child: Stack(
          children: [
              CustomPaint(
                  size: Size(tileHeight, tileWidth),
                  painter: painter
              ),

              TileTop(
                  tileHeight: tileHeight,
                  tileWidth: tileWidth,
                  tileOffSet: tileOffSet,
                  tileIndex: tileIndex,
                  primaryColor: usedColor,
                  unusedTile: unusedTile)
          ]
        )
      ),
    );
  }
}


class TileTop extends StatefulWidget{
  const TileTop({super.key,
    required this.tileHeight,
    required this.tileWidth,
    required this.tileOffSet,
    required this.tileIndex,
    required this.primaryColor,
    required this.unusedTile});

  final double tileHeight;
  final double tileWidth;
  final double tileOffSet;
  final int tileIndex;
  final Color primaryColor;
  final bool unusedTile;

  @override
  State<TileTop> createState() => _TileTop();
}
class _TileTop extends State<TileTop>{
  get primaryColor => widget.primaryColor;


  @override
  Widget build(BuildContext context){
    return Container(
        height: widget.tileHeight,
        width: widget.tileWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
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
            blurRadius: 4,
            offset: const Offset(0.5, 0.5),
            blurStyle: BlurStyle.solid
          )
        ]
      ),
      child: Center(
        child: Text(widget.tileIndex.toString())
      )
    );

  }
}

// played with height from size.height
//
class TilePainter extends CustomPainter{
  TilePainter({required this.unusedTile});

  final double edgeRadius = 2;
  final bool unusedTile;

  final tilePaint = Paint();
  double depth = 8; // normally 20

  @override
  void paint(Canvas canvas, Size size){
    if (unusedTile == true){
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