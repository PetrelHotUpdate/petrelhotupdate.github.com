import 'package:flutter/material.dart';

class FloatingCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double maxOffset;
  final Color? shadowColor;

  const FloatingCard({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.maxOffset = 10.0,
    this.shadowColor,
  });

  @override
  State<FloatingCard> createState() => _FloatingCardState();
}

class _FloatingCardState extends State<FloatingCard>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _hoverController;
  late Animation<double> _floatAnimation;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    
    _floatController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _floatAnimation = Tween<double>(
      begin: -widget.maxOffset,
      end: widget.maxOffset,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));

    _hoverAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _floatController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_floatAnimation, _hoverAnimation]),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: Transform.scale(
              scale: _hoverAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: (widget.shadowColor ?? Colors.black)
                          .withOpacity(_isHovered ? 0.3 : 0.1),
                      blurRadius: _isHovered ? 20 : 10,
                      offset: Offset(0, _isHovered ? 10 : 5),
                      spreadRadius: _isHovered ? 2 : 0,
                    ),
                  ],
                ),
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }
}
