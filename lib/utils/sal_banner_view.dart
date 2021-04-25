import 'package:flutter/material.dart';
import 'package:sal_patient_client/common/sal_colors.dart';

class SalThemeBannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: BackgroundPainter());
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = SalColors.blue
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
