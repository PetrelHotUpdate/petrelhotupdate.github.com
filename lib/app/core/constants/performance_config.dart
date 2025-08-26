class PerformanceConfig {
  // 性能模式枚举
  static const String highPerformance = 'high';
  static const String balanced = 'balanced';
  static const String lowPower = 'low_power';

  // 默认性能模式
  static const String defaultMode = balanced;

  // 粒子数量配置
  static const Map<String, int> particleCounts = {
    highPerformance: 60,
    balanced: 40,
    lowPower: 20,
  };

  // 动画持续时间配置
  static const Map<String, Duration> animationDurations = {
    highPerformance: Duration(seconds: 8),
    balanced: Duration(seconds: 12),
    lowPower: Duration(seconds: 20),
  };

  // 浮动卡片配置
  static const Map<String, double> floatingOffsets = {
    highPerformance: 8.0,
    balanced: 6.0,
    lowPower: 4.0,
  };

  // 是否启用复杂动画
  static const Map<String, bool> enableComplexAnimations = {
    highPerformance: true,
    balanced: true,
    lowPower: false,
  };

  // 是否启用粒子连接线
  static const Map<String, bool> enableParticleConnections = {
    highPerformance: true,
    balanced: true,
    lowPower: false,
  };

  // 获取当前配置的粒子数量
  static int getParticleCount(String mode) {
    return particleCounts[mode] ?? particleCounts[balanced]!;
  }

  // 获取当前配置的动画持续时间
  static Duration getAnimationDuration(String mode) {
    return animationDurations[mode] ?? animationDurations[balanced]!;
  }

  // 获取当前配置的浮动偏移量
  static double getFloatingOffset(String mode) {
    return floatingOffsets[mode] ?? floatingOffsets[balanced]!;
  }

  // 获取是否启用复杂动画
  static bool shouldEnableComplexAnimations(String mode) {
    return enableComplexAnimations[mode] ?? enableComplexAnimations[balanced]!;
  }

  // 获取是否启用粒子连接线
  static bool shouldEnableParticleConnections(String mode) {
    return enableParticleConnections[mode] ??
        enableParticleConnections[balanced]!;
  }

  // 根据设备性能自动选择模式
  static String getAutoPerformanceMode({
    required double devicePixelRatio,
    required double screenWidth,
    required double screenHeight,
    required int memorySize, // 内存大小（MB）
  }) {
    // 高性能设备判断
    if (devicePixelRatio <= 2.0 &&
        screenWidth <= 1200 &&
        screenHeight <= 800 &&
        memorySize >= 4000) {
      return highPerformance;
    }

    // 低功耗设备判断
    if (devicePixelRatio > 3.0 ||
        screenWidth > 2000 ||
        screenHeight > 1200 ||
        memorySize < 2000) {
      return lowPower;
    }

    // 默认平衡模式
    return balanced;
  }
}
