import'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as config;
import 'package:ann_app/colors.dart';

class BodyPainter extends CustomPainter {
  BodyPainter({required this.context});
  final bodyPaint = Paint();
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    MaterialColor themePrimary = Theme.of(context).primaryColor as MaterialColor;
    bodyPaint.shader = ui.Gradient.linear(
      const Offset(0, 20),
      const Offset(20, 0),
      [
        themePrimary.shade600,
        themePrimary.shade500,
        themePrimary.shade300,
        themePrimary.shade100,
        themePrimary.shade200,
        themePrimary.shade500,
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
  bool shouldRepaint(BodyPainter oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(BodyPainter oldDelegate) => true;
}