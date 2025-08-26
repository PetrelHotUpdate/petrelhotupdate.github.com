import 'package:flutter/material.dart';

class FloatingCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double maxOffset;
  final Color? shadowColor;

  const FloatingCard({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 4), // 增加动画周期
    this.maxOffset = 6.0, // 减少浮动幅度
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
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300), // 增加悬停动画时间
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
      end: 1.03, // 减少悬停缩放幅度
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
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
          _floatController.repeat(reverse: true);
        } else {
          _floatController.stop();
        }
      }
    }
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
        if (!_isVisible) return;
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
          if (!_isVisible) {
            // 如果不可见，返回静态版本
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color:
                        (widget.shadowColor ?? Colors.black).withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: widget.child,
            );
          }

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
                          .withOpacity(_isHovered ? 0.25 : 0.1),
                      blurRadius: _isHovered ? 15 : 10,
                      offset: Offset(0, _isHovered ? 8 : 5),
                      spreadRadius: _isHovered ? 1 : 0,
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
