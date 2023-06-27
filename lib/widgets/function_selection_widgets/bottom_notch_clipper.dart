

import 'package:flutter/cupertino.dart';

class BottomNotchClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path()
    ..moveTo(0, 0)
    ..lineTo(0, height)
      ..lineTo((width/2) - 35, height)
      ..quadraticBezierTo(width/ 2, height - 65, (width/2) + 35, height)

    // ..lineTo((width/2) - 20, height)
    // ..lineTo((width/2) - 20, height - 10)
    // ..lineTo((width/2) + 20, height - 10)
    // ..lineTo((width/2) + 20, height)

    ..lineTo(width, height)
    ..lineTo(width, 0)
    ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }


}