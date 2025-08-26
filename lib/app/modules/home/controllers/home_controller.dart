import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/performance_config.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  final isLoading = false.obs;
  final performanceMode = PerformanceConfig.defaultMode.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    
    // 创建TabController
    tabController = TabController(length: 3, vsync: this);
    
    // 自动检测设备性能并设置合适的模式
    _autoDetectPerformanceMode();
  }

  void _autoDetectPerformanceMode() {
    try {
      final devicePixelRatio = Get.mediaQuery.devicePixelRatio;
      final screenWidth = Get.mediaQuery.size.width;
      final screenHeight = Get.mediaQuery.size.height;
      
      // 估算内存大小（这里使用一个简单的估算方法）
      final estimatedMemory = _estimateMemorySize();
      
      final autoMode = PerformanceConfig.getAutoPerformanceMode(
        devicePixelRatio: devicePixelRatio,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        memorySize: estimatedMemory,
      );
      
      performanceMode.value = autoMode;
      
      print('自动检测性能模式: $autoMode');
      print(
          '设备信息: DPR=$devicePixelRatio, 屏幕=${screenWidth}x$screenHeight, 估算内存=${estimatedMemory}MB');
    } catch (e) {
      print('性能检测失败，使用默认模式: $e');
      performanceMode.value = PerformanceConfig.defaultMode;
    }
  }

  int _estimateMemorySize() {
    // 简单的内存估算，实际项目中可以使用更准确的方法
    try {
      // 这里可以根据平台获取实际内存信息
      // 暂时使用一个基于屏幕分辨率的估算
      final screenWidth = Get.mediaQuery.size.width;
      final screenHeight = Get.mediaQuery.size.height;
      final pixelCount = screenWidth * screenHeight;
      
      if (pixelCount > 2000000) return 8000; // 4K+ 屏幕
      if (pixelCount > 1000000) return 4000; // 2K 屏幕
      if (pixelCount > 500000) return 2000; // 1080p 屏幕
      return 1000; // 低分辨率屏幕
    } catch (e) {
      return 2000; // 默认值
    }
  }

  void setPerformanceMode(String mode) {
    if (PerformanceConfig.particleCounts.containsKey(mode)) {
      performanceMode.value = mode;
      update(); // 通知UI更新
    }
  }

  void togglePerformanceMode() {
    final modes = PerformanceConfig.particleCounts.keys.toList();
    final currentIndex = modes.indexOf(performanceMode.value);
    final nextIndex = (currentIndex + 1) % modes.length;
    setPerformanceMode(modes[nextIndex]);
  }

  void goToGitHub() async {
    const url = 'https://github.com/your-repo/petrel-hot-update';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void goToDocs() {
    Get.toNamed('/docs');
  }

  void goToDemo() {
    Get.snackbar(
      '演示功能',
      '演示页面正在开发中...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
