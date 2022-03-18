import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 396;
    path.lineTo(427.5 * _xScaling, 0 * _yScaling);
    path.cubicTo(
      427.5 * _xScaling,
      0 * _yScaling,
      427.5 * _xScaling,
      200.4 * _yScaling,
      427.5 * _xScaling,
      200.4 * _yScaling,
    );
    path.cubicTo(
      401.64 * _xScaling,
      238.358 * _yScaling,
      366.892 * _xScaling,
      269.418 * _yScaling,
      326.281 * _xScaling,
      290.874 * _yScaling,
    );
    path.cubicTo(
      285.671 * _xScaling,
      312.329 * _yScaling,
      240.43 * _xScaling,
      323.53 * _yScaling,
      194.5 * _xScaling,
      323.5 * _yScaling,
    );
    path.cubicTo(
      122.299 * _xScaling,
      323.601 * _yScaling,
      52.8292 * _xScaling,
      295.906 * _yScaling,
      0.5 * _xScaling,
      246.16 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      246.16 * _yScaling,
      0.5 * _xScaling,
      0 * _yScaling,
      0.5 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      0 * _yScaling,
      427.5 * _xScaling,
      0 * _yScaling,
      427.5 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      427.5 * _xScaling,
      0 * _yScaling,
      427.5 * _xScaling,
      0 * _yScaling,
      427.5 * _xScaling,
      0 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
