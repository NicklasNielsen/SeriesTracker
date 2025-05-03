
import 'dart:ui';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

class FocusButton extends StatelessWidget {
  FocusButton({
    required this.inFocus,
    required this.unFocus,
    super.key
  }): _focus = ValueNotifier(null);

  final Widget Function(FocusNode, VoidCallback) inFocus;
  final Widget unFocus;
  final ValueNotifier<FocusNode?> _focus;
  
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => _focus.value = FocusNode(),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: _focus,
            builder: (context, focus, _) => focus != null
              ? inFocus(focus, () => _focus.value = null)
              : unFocus,
          ),
          Positioned.fill(
            child: CustomPaint(painter: DashPainter()),
          ),
        ],
      ),
    ),
  );
}

class DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(16)));

    Path dashedPath = Path();
    double totalLength = path.computeMetrics().map((m) => m.length).reduce((a, b) => a + b);
    int dashCount = (totalLength / 16).round();
    double dashWidth = totalLength / (dashCount * 2);
    double dashSpace = dashWidth;
    double distance = 0;

    for (PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        dashedPath.addPath(metric.extractPath(distance, distance + dashWidth), Offset.zero);
        distance += dashWidth + dashSpace - 0.04;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}