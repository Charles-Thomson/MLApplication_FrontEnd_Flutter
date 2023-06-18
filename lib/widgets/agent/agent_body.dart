import 'package:flutter/material.dart';
import'dart:ui' as ui;
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;

class AgentBody extends CustomPainter {
  AgentBody();

  final agentPaint = Paint();
  double agentHeight = maze_config.agentDrawHeight;
  double  agentWidth = maze_config.agentDrawWidth;

  @override
  void paint(Canvas canvas, Size size) {
    agentPaint.shader = ui.Gradient.linear(
        const Offset(0, 5),
        const Offset(5, 0),
        [
          Colors.blue.shade100,
          Colors.blue.shade200,
          Colors.blue.shade500,
          Colors.blue.shade700,
        ],
      [0.01, 0.2, 0.29, 0.6], // stops
    );

    double radiosOffset = 10;
    double tileCenter = agentWidth / 4;
    final agentPath = Path()
    ..addRRect(RRect.fromRectAndRadius(
           Rect.fromLTWH(tileCenter, tileCenter, 15, 15),
          Radius.circular(radiosOffset))
      );

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