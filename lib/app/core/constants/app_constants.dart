class AppConstants {
  // 应用信息
  static const String appName = 'Petrel（海燕）';
  static const String appSubtitle = 'Flutter热更新框架';
  static const String appDescription = '基于Flutter Web的热更新技术，让你的Flutter应用支持动态更新';

  // 链接
  static const String githubUrl = 'https://github.com/PetrelHotUpdate/Petrel';
  static const String documentUrl = 'https://petrelhotupdate.github.io';
  static const String demoUrl = 'https://juejin.cn/post/7541801054180261914';

  // 特性列表
  static const List<Map<String, String>> features = [
    {
      'title': '六层架构',
      'description':
          'Petrel层、Base层、Page层、Flutter Web+Flutter Petrel层、插件层、原生App层的清晰分离',
      'icon': '🏗️'
    },
    {'title': '热更新', 'description': '支持页面级别的动态更新，无需重新发布应用', 'icon': '🔥'},
    {'title': '跨平台', 'description': '支持iOS、Android、Web等多平台部署', 'icon': '📱'},
    {'title': '易集成', 'description': '简单的API设计，快速集成到现有项目', 'icon': '⚡'},
  ];

  // 架构说明
  static const Map<String, String> architectureInfo = {
    'Petrel层': '核心热更新引擎，提供热更新的核心功能和API接口。包含热更新引擎、核心API、版本管理等核心功能，是框架的核心层。',
    'Base层': '基础功能和服务层，提供通用的业务逻辑和工具服务。包含基础服务、工具类、业务逻辑等基础设施，实现业务逻辑与平台细节的解耦。',
    'Page层': '页面层，包含所有需要支持热更新的页面和组件。支持热更新、动态加载、页面管理等功能，是热更新的主要目标层。',
    'Flutter Web + Flutter Petrel层':
        'Flutter Web负责将代码编译成Web可执行的代码，Flutter Petrel负责拦截和展示热更新页面，两者协同工作。',
    '插件层': '原生插件层，用来实现原生插件调用部分，提供原生功能访问能力。包含原生功能、插件管理、平台适配等。',
    '原生App层': '原生应用层，用于处理原生逻辑和系统级功能。包含系统集成、原生逻辑、平台特性等。'
  };
}
