import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class TilePainter extends CustomPainter{
  TilePainter({required this.tileState, required this.depth, required Listenable repaint}): super(repaint: repaint);

  final double edgeRadius = 2;
  final double depth;
  final tilePaint = Paint();

  int tileState;
  //double depth = depth; // normally 20

  get newTileState => tileState;

  @override
  void paint(Canvas canvas, Size size){
    // tileState ++;
    // //double depth = 8; // normally 20
    // print("In painter with state value of $newTileState");
    // if (tileState == 2){
    //   print("Changing depth on the painter");
    //   depth = 0;
    //
    // }
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
  bool shouldRepaint(TilePainter oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(TilePainter oldDelegate) => true;
}