import'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as config;

class BodyPainter extends CustomPainter {
  BodyPainter();

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
    double radiosOffset = config.edgeRadius;
    double borderRadiusOffset =
        (radiosOffset * sqrt(2) - radiosOffset) / sqrt(2);
    double distance = 30;
    final bodyPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, config.mazeWidth, config.mazeHeight),
          Radius.circular(radiosOffset))
      )

      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(distance, distance, config.mazeWidth, config.mazeHeight),
          Radius.circular(radiosOffset))
      )
      ..moveTo(config.mazeWidth - borderRadiusOffset, borderRadiusOffset)
      ..lineTo(
        config.mazeWidth + distance - borderRadiusOffset,
        distance + borderRadiusOffset,
      )
      ..lineTo(
      distance + borderRadiusOffset,
        config.mazeHeight + distance - borderRadiusOffset,
      )
      ..lineTo(borderRadiusOffset, config.mazeHeight - borderRadiusOffset);

    canvas.drawShadow(
      bodyPath,
      Colors.grey.shade700.withOpacity(0.8),
      5,
      false,
    );
    canvas.drawPath(bodyPath, bodyPaint);
  }

  @override
  bool shouldRepaint(BodyPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(BodyPainter oldDelegate) => false;
}