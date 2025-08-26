import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/performance_config.dart';
import '../../../core/utils/responsive.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/home_controller.dart';
import '../widgets/particle_background.dart';
import '../widgets/glassmorphism_card.dart';
import '../widgets/neon_button.dart';
import '../widgets/floating_card.dart';
import '../widgets/animated_gradient_background.dart';

class HomeViewOptimized extends GetView<HomeController> {
  const HomeViewOptimized({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final mode = controller.performanceMode.value;
        final particleCount = PerformanceConfig.getParticleCount(mode);
        final animationDuration = PerformanceConfig.getAnimationDuration(mode);

        return AnimatedGradientBackground(
          duration: animationDuration,
          colors: const [
            Color(0xFF667eea),
            Color(0xFF764ba2),
            Color(0xFF6B73FF),
            Color(0xFF9A9CE3),
            Color(0xFF667eea),
          ],
          child: ParticleBackground(
            particleCount: particleCount,
            particleColor: Colors.white.withOpacity(0.4),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeroSection(context),
                  _buildFeaturesSection(context),
                  _buildArchitectureSection(context),
                  _buildComparisonSection(context),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // 这里可以添加其他方法的实现...
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      padding: Responsive.getPadding(context),
      child: const Center(
        child: Text(
          'Hero Section - 优化版本',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      child: const Center(
        child: Text(
          'Features Section - 优化版本',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildArchitectureSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      child: const Center(
        child: Text(
          'Architecture Section - 优化版本',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildComparisonSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      child: const Center(
        child: Text(
          'Comparison Section - 优化版本',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      child: const Center(
        child: Text(
          'Footer - 优化版本',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
