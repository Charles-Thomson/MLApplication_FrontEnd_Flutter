import'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';



class BodyPainter extends CustomPainter {
  BodyPainter({required this.edgeRadius});

  final double edgeRadius;

  final bodyPaint = Paint();
  
  
  @override
  void paint(Canvas canvas, Size size) {
    bodyPaint.shader = ui.Gradient.linear(
      const Offset(0, 20),
      const Offset(20, 0),
      [
        Colors.grey.shade700,
        Colors.grey.shade500,
        Colors.grey.shade300,
        Colors.grey.shade100,
        Colors.grey.shade200,
        Colors.grey.shade700,
      ],
      [0.01, 0.2, 0.49, 0.52, 0.6, 1],
    );
    double radiosOffset = edgeRadius;
    double borderRadiusOffset =
        (radiosOffset * sqrt(2) - radiosOffset) / sqrt(2);
    double distance = 30;
    final bodyPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radiosOffset))
      )

      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(distance, distance, size.width, size.height),
          Radius.circular(radiosOffset))
      )
      ..moveTo(size.width - borderRadiusOffset, borderRadiusOffset)
      ..lineTo(
        size.width + distance - borderRadiusOffset,
        distance + borderRadiusOffset,
      )
      ..lineTo(
      distance + borderRadiusOffset,
      size.height + distance - borderRadiusOffset,
      )
      ..lineTo(borderRadiusOffset, size.height - borderRadiusOffset);

    canvas.drawShadow(
      bodyPath,
      Colors.grey.shade700.withOpacity(0.8),
      5,
      false,
    );

    canvas.drawPath(bodyPath, bodyPaint);


  }
  

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(BodyPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(BodyPainter oldDelegate) => false;
}