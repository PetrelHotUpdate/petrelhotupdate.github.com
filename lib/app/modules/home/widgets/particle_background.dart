import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParticleBackground extends StatefulWidget {
  final Widget child;
  final int particleCount;
  final Color particleColor;

  const ParticleBackground({
    super.key,
    required this.child,
    this.particleCount = 30, // 减少默认粒子数量
    this.particleColor = Colors.white,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30), // 增加动画周期，减少更新频率
      vsync: this,
    )..repeat();

    particles = List.generate(widget.particleCount, (index) => Particle());

    // 添加可见性检测
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (mounted) {
      final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;
        final screenSize = MediaQuery.of(context).size;

        // 如果组件不在可视区域内，暂停动画
        _isVisible = position.dx < screenSize.width &&
            position.dx + size.width > 0 &&
            position.dy < screenSize.height &&
            position.dy + size.height > 0;

        if (_isVisible) {
          _controller.repeat();
        } else {
          _controller.stop();
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: ParticlePainter(
                particles: particles,
                animation: _controller,
                color: widget.particleColor,
                isVisible: _isVisible,
              ),
              size: Size.infinite,
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class Particle {
  late double x;
  late double y;
  late double vx;
  late double vy;
  late double size;
  late double opacity;
  late double lastUpdateTime;

  Particle() {
    reset();
  }

  void reset() {
    x = math.Random().nextDouble();
    y = math.Random().nextDouble();
    vx = (math.Random().nextDouble() - 0.5) * 0.001; // 减少速度
    vy = (math.Random().nextDouble() - 0.5) * 0.001;
    size = math.Random().nextDouble() * 2 + 0.5; // 减少粒子大小
    opacity = math.Random().nextDouble() * 0.3 + 0.1; // 减少透明度
    lastUpdateTime = 0;
  }

  void update(double deltaTime) {
    // 限制更新频率
    if (deltaTime - lastUpdateTime < 0.016) return; // 60fps限制

    x += vx;
    y += vy;
    lastUpdateTime = deltaTime;

    if (x < 0 || x > 1 || y < 0 || y > 1) {
      reset();
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Animation<double> animation;
  final Color color;
  final bool isVisible;

  ParticlePainter({
    required this.particles,
    required this.animation,
    required this.color,
    required this.isVisible,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isVisible) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final currentTime = animation.value;

    for (final particle in particles) {
      particle.update(currentTime);

      paint.color = color.withOpacity(particle.opacity);
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }

    // 优化连接线绘制，减少计算量
    final maxConnections = 20; // 限制最大连接线数量
    int connectionCount = 0;

    for (int i = 0;
        i < particles.length && connectionCount < maxConnections;
        i++) {
      for (int j = i + 1;
          j < particles.length && connectionCount < maxConnections;
          j++) {
        final p1 = particles[i];
        final p2 = particles[j];

        final distance = math.sqrt(
          math.pow((p1.x - p2.x) * size.width, 2) +
              math.pow((p1.y - p2.y) * size.height, 2),
        );

        if (distance < 80) {
          // 减少连接线距离
          final linePaint = Paint()
            ..color = color.withOpacity((1 - distance / 80) * 0.15) // 减少透明度
            ..strokeWidth = 0.5; // 减少线条宽度

          canvas.drawLine(
            Offset(p1.x * size.width, p1.y * size.height),
            Offset(p2.x * size.width, p2.y * size.height),
            linePaint,
          );
          connectionCount++;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
