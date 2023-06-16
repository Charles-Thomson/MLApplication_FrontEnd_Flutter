import 'dart:math';
import 'package:flutter/material.dart';
import'dart:ui' as ui;

class AgentBody extends CustomPainter {
  AgentBody();

  final agentPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    agentPaint.shader = ui.Gradient.linear(
        const Offset(0, 20),
        const Offset(20, 0),
        [
          Colors.blue.shade100,
          Colors.blue.shade200,
          Colors.blue.shade500,
          Colors.blue.shade700,
        ],
      [0.01, 0.2, 0.29, 0.6], // stops
    );

    double radiosOffset = 10;
    double borderRadiusOffset =
        (radiosOffset * sqrt(2) - radiosOffset) / sqrt(2);
    double distance = 10;

    final agentPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
          const Rect.fromLTWH(20, 20, 20, 20),
          Radius.circular(radiosOffset))
      )
    ..addRRect(RRect.fromRectAndRadius(
          const Rect.fromLTWH(23, 10, 12, 12),
          Radius.circular(radiosOffset))
      )
      // Left leg
      ..moveTo(20, 40)
      ..lineTo(
        20 , 45
      )..lineTo(
        26, 45
      )..lineTo(26, 40)

      // Right leg
      ..moveTo(32, 40)
      ..lineTo(
        32 , 45
      )..lineTo(
        38, 45
      )..lineTo(38, 40);



    canvas.drawShadow(
      agentPath,
      Colors.grey.shade700.withOpacity(0.8),
      5,
      false,
    );

    canvas.drawPath(agentPath, agentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}