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
    this.duration = const Duration(seconds: 8),
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _animations = List.generate(
      4,
      (index) => Tween<double>(
        begin: 0.0,
        end: 2 * math.pi,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          index * 0.25,
          1.0,
          curve: Curves.easeInOut,
        ),
      )),
    );
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
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                math.cos(_animations[0].value),
                math.sin(_animations[0].value),
              ),
              end: Alignment(
                math.cos(_animations[1].value + math.pi),
                math.sin(_animations[1].value + math.pi),
              ),
              colors: [
                Color.lerp(
                  widget.colors[0],
                  widget.colors[1],
                  (math.sin(_animations[2].value) + 1) / 2,
                )!,
                Color.lerp(
                  widget.colors[2],
                  widget.colors[3],
                  (math.cos(_animations[3].value) + 1) / 2,
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
