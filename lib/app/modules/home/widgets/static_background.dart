import 'package:flutter/material.dart';
import 'dart:math' as math;

class StaticBackground extends StatelessWidget {
  final Widget child;
  final List<Color> colors;

  const StaticBackground({
    super.key,
    required this.child,
    this.colors = const [
      Color(0xFF667eea),
      Color(0xFF764ba2),
      Color(0xFF6B73FF),
      Color(0xFF9A9CE3),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: CustomPaint(
        painter: StaticBackgroundPainter(),
        size: Size.infinite,
        child: child,
      ),
    );
  }
}

class StaticBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // 绘制静态装饰元素
    _drawStaticParticles(canvas, size, paint);
    _drawStaticLines(canvas, size, paint);
  }

  void _drawStaticParticles(Canvas canvas, Size size, Paint paint) {
    final random = math.Random(42); // 固定种子，确保每次绘制结果一致

    for (int i = 0; i < 25; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 0.5;
      final opacity = random.nextDouble() * 0.2 + 0.05;

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  void _drawStaticLines(Canvas canvas, Size size, Paint paint) {
    final random = math.Random(42);
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 15; i++) {
      final x1 = random.nextDouble() * size.width;
      final y1 = random.nextDouble() * size.height;
      final x2 = random.nextDouble() * size.width;
      final y2 = random.nextDouble() * size.height;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
