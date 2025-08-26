import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;

  const AnimatedGradientBackground({
    super.key,
    required this.child,
    this.colors = const [
      Color(0xFF667eea),
      Color(0xFF764ba2),
      Color(0xFF6B73FF),
      Color(0xFF9A9CE3),
    ],
    this.duration = const Duration(seconds: 12), // 增加动画周期
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _colorAnimation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    // 简化动画，只使用两个动画控制器
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));

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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (!_isVisible) {
          // 如果不可见，使用静态渐变
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.colors,
              ),
            ),
            child: widget.child,
          );
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                math.cos(_rotationAnimation.value),
                math.sin(_rotationAnimation.value),
              ),
              end: Alignment(
                math.cos(_rotationAnimation.value + math.pi),
                math.sin(_rotationAnimation.value + math.pi),
              ),
              colors: [
                Color.lerp(
                  widget.colors[0],
                  widget.colors[1],
                  (math.sin(_colorAnimation.value) + 1) / 2,
                )!,
                Color.lerp(
                  widget.colors[2],
                  widget.colors[3],
                  (math.cos(_colorAnimation.value) + 1) / 2,
                )!,
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
