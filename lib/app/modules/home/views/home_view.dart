import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/home_controller.dart';
import '../widgets/particle_background.dart';
import '../widgets/glassmorphism_card.dart';
import '../widgets/neon_button.dart';
import '../widgets/floating_card.dart';
import '../widgets/animated_gradient_background.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        colors: const [
          Color(0xFF667eea),
          Color(0xFF764ba2),
          Color(0xFF6B73FF),
          Color(0xFF9A9CE3),
          Color(0xFF667eea),
        ],
        child: ParticleBackground(
          particleCount: 80,
          particleColor: Colors.white.withOpacity(0.6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(context),
                _buildFeaturesSection(context),
                _buildArchitectureSection(context),
                // _buildStatsSection(context), // 暂时屏蔽项目数据模块
                _buildComparisonSection(context),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      padding: Responsive.getPadding(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),

          // Logo和标题容器
          GlassmorphismCard(
            blur: 15,
            opacity: 0.15,
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Logo with glow effect
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Assets.images.petrel.image(
                        width: Responsive.isMobile(context) ? 164 : 204,
                        height: Responsive.isMobile(context) ? 164 : 204,
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0),
                    )
                    .then()
                    .shimmer(duration: 2000.ms),

                const SizedBox(height: 40),

                // 主标题
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Colors.white,
                      Color(0xFFE3F2FD),
                      Colors.white,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: Responsive.getFontSize(context,
                              mobile: 36, tablet: 48, desktop: 56),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 800.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 20),

                // 副标题
                Text(
                  AppConstants.appSubtitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: Responsive.getFontSize(context,
                            mobile: 20, tablet: 26, desktop: 28),
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 500.ms, duration: 800.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 30),

                // 描述文字
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    AppConstants.appDescription,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: Responsive.getFontSize(context,
                              mobile: 16, tablet: 18, desktop: 20),
                          height: 1.8,
                          color: Colors.white.withOpacity(0.8),
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 700.ms, duration: 800.ms)
                    .slideY(begin: 0.3, end: 0),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // 操作按钮组
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              Obx(() => NeonButton(
                    text: '查看源码',
                    icon: Icons.code,
                    onPressed: controller.goToGitHub,
                    color: const Color(0xFF00BCD4),
                    width: 160,
                    height: 55,
                    isLoading: controller.isLoading.value,
                  )),
              NeonButton(
                text: '查看文档',
                icon: Icons.book,
                onPressed: controller.goToDocs,
                color: const Color(0xFF9C27B0),
                width: 160,
                height: 55,
              ),
              NeonButton(
                text: '查看演示',
                icon: Icons.play_arrow,
                onPressed: () => controller.goToDemo(),
                color: const Color(0xFFFF5722),
                width: 160,
                height: 55,
              ),
            ],
          )
              .animate()
              .fadeIn(delay: 900.ms, duration: 800.ms)
              .slideY(begin: 0.5, end: 0),

          const SizedBox(height: 100),

          // 滚动提示
          Column(
            children: [
              Text(
                '向下滚动探索更多',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withOpacity(0.7),
                size: 30,
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .moveY(begin: 0, end: 10, duration: 1000.ms)
                  .then()
                  .moveY(begin: 10, end: 0, duration: 1000.ms),
            ],
          ).animate().fadeIn(delay: 1200.ms, duration: 800.ms),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      child: Column(
        children: [
          const SizedBox(height: 80),

          // 标题
          GlassmorphismCard(
            blur: 10,
            opacity: 0.1,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              '🚀 核心特性',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Responsive.getFontSize(context,
                        mobile: 28, tablet: 32, desktop: 36),
                  ),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(duration: 800.ms).scale(),

          const SizedBox(height: 60),

          // 特性卡片网格
          Responsive.isDesktop(context)
              ? Row(
                  children: AppConstants.features
                      .asMap()
                      .entries
                      .map((entry) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: _buildFeatureCard(
                                  context, entry.value, entry.key),
                            ),
                          ))
                      .toList(),
                )
              : Column(
                  children: AppConstants.features
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _buildFeatureCard(
                                context, entry.value, entry.key),
                          ))
                      .toList(),
                ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, Map<String, String> feature, int index) {
    final colors = [
      const Color(0xFF00BCD4),
      const Color(0xFF9C27B0),
      const Color(0xFFFF5722),
      const Color(0xFF4CAF50),
    ];

    return FloatingCard(
      duration: Duration(milliseconds: 3000 + index * 500),
      maxOffset: 8.0,
      shadowColor: colors[index % colors.length],
      child: GlassmorphismCard(
        blur: 15,
        opacity: 0.15,
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 图标容器
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors[index % colors.length].withOpacity(0.9),
                    colors[index % colors.length].withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors[index % colors.length].withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  feature['icon']!,
                  style: const TextStyle(
                    fontSize: 36,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 标题
            Text(
              feature['title']!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // 描述
            Text(
              feature['description']!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    height: 1.6,
                    fontSize: 14,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // 装饰线
            Container(
              width: 50,
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors[index % colors.length],
                    colors[index % colors.length].withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 200 * index))
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.3, end: 0);
  }

  /// 构建架构设计部分，包含架构介绍和热更新流程图
  Widget _buildArchitectureSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      child: Column(
        children: [
          const SizedBox(height: 80),

          GlassmorphismCard(
            blur: 10,
            opacity: 0.1,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              '🏗️ 六层架构设计',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Responsive.getFontSize(context,
                        mobile: 28, tablet: 32, desktop: 36),
                  ),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(duration: 800.ms).scale(),

          const SizedBox(height: 60),

          // 架构标签页区域
          GlassmorphismCard(
            blur: 15,
            opacity: 0.1,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TDTabBar(
                  tabs: const [
                    TDTab(text: '核心架构'),
                    TDTab(text: '层级详解'),
                    TDTab(text: '技术栈'),
                  ],
                  controller: controller.tabController,
                  backgroundColor: Colors.transparent,
                  indicatorColor: const Color(0xFF00BCD4),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withOpacity(0.6),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 420,
                  child: TDTabBarView(
                    controller: controller.tabController,
                    children: [
                      _buildCoreArchitectureTab(context),
                      _buildLayerDetailsTab(context),
                      _buildTechStackTab(context),
                    ],
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 800.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 80),

          // 热更新流程可视化区域
          GlassmorphismCard(
            blur: 10,
            opacity: 0.1,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              '🔄 热更新流程',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Responsive.getFontSize(context,
                        mobile: 28, tablet: 32, desktop: 36),
                  ),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(duration: 800.ms).scale(delay: 200.ms),

          const SizedBox(height: 60),

          // 热更新流程图
          GlassmorphismCard(
            blur: 15,
            opacity: 0.15,
            padding: const EdgeInsets.all(30),
            child: _buildUpdateFlowDiagram(context),
          )
              .animate()
              .fadeIn(delay: 600.ms, duration: 800.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  /// 构建核心架构标签页
  Widget _buildCoreArchitectureTab(BuildContext context) {
    return GlassmorphismCard(
      blur: 10,
      opacity: 0.15,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '六层架构核心设计',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00BCD4),
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 24),

          // 六层架构图
          Expanded(
            child: _buildSixLayerArchitecture(context),
          ),

          const SizedBox(height: 20),

          Text(
            'Petrel采用创新的六层架构设计，每一层都有明确的职责分工，'
            '实现了Flutter Web与Native的无缝融合，支持真正的页面级热更新。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 构建六层架构图
  Widget _buildSixLayerArchitecture(BuildContext context) {
    final layers = [
      {
        'name': '原生App层',
        'desc': '处理原生逻辑',
        'color': Colors.red,
        'icon': Icons.phone_android
      },
      {
        'name': '插件层',
        'desc': '实现原生插件调用',
        'color': Colors.orange,
        'icon': Icons.extension
      },
      {
        'name': 'Flutter Web + Flutter Petrel',
        'desc': 'Web编译代码 + 拦截展示热更页面',
        'color': Colors.yellow,
        'icon': Icons.flutter_dash
      },
      {
        'name': 'Page层',
        'desc': '支持热更新的页面',
        'color': Colors.green,
        'icon': Icons.pages
      },
      {
        'name': 'Base层',
        'desc': '基础功能和服务',
        'color': Colors.indigo,
        'icon': Icons.build
      },
      {
        'name': 'Petrel层',
        'desc': '核心热更新引擎',
        'color': Colors.purple,
        'icon': Icons.library_books
      },
    ];

    return Container(
      height: Responsive.isDesktop(context) ? 350 : 650, // 进一步增加高度
      child: Responsive.isDesktop(context)
          ? _buildDesktopArchitecture(context, layers)
          : _buildMobileArchitecture(context, layers),
    );
  }

  /// 构建桌面端架构图
  Widget _buildDesktopArchitecture(
      BuildContext context, List<Map<String, dynamic>> layers) {
    return Stack(
      children: [
        // 连接线
        Positioned.fill(
          child: CustomPaint(
            painter: DesktopArchitectureConnectorPainter(),
          ),
        ),

        // 各层架构 - 水平排列
        for (int i = 0; i < layers.length; i++)
          Positioned(
            left: 20 + (i * 140),
            top: 100,
            child: _buildArchitectureLayer(
              context,
              layers[i],
              i,
              Axis.vertical,
            ),
          ),
      ],
    );
  }

  /// 构建移动端架构图
  Widget _buildMobileArchitecture(
      BuildContext context, List<Map<String, dynamic>> layers) {
    return Stack(
      children: [
        // 连接线
        Positioned.fill(
          child: CustomPaint(
            painter: MobileArchitectureConnectorPainter(),
          ),
        ),

        // 各层架构 - 垂直排列
        for (int i = 0; i < layers.length; i++)
          Positioned(
            left: 20,
            top: 20 + (i * 90), // 增加间距到90px
            child: _buildArchitectureLayer(
              context,
              layers[i],
              i,
              Axis.horizontal,
            ),
          ),
      ],
    );
  }

  /// 构建单个架构层
  Widget _buildArchitectureLayer(BuildContext context,
      Map<String, dynamic> layer, int index, Axis direction) {
    final color = layer['color'] as Color;
    final isVertical = direction == Axis.vertical;

    return Container(
      width: isVertical ? 120 : 140,
      height: isVertical ? 100 : 70,
      child: FloatingCard(
        duration: Duration(milliseconds: 2000 + index * 300),
        maxOffset: 3.0,
        shadowColor: color,
        child: GlassmorphismCard(
          blur: 15,
          opacity: 0.2,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 图标
              Flexible(
                child: Container(
                  width: isVertical ? 28 : 22,
                  height: isVertical ? 28 : 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.9),
                        color.withOpacity(0.7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    layer['icon'],
                    color: Colors.white,
                    size: isVertical ? 16 : 14,
                  ),
                ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                    duration: 2000.ms,
                    delay: Duration(milliseconds: index * 400)),
              ),

              const SizedBox(height: 4),

              // 名称
              Flexible(
                child: Text(
                  layer['name'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: isVertical ? 10 : 9,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: isVertical ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 2),

              // 描述
              Flexible(
                child: Text(
                  layer['desc'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: isVertical ? 8 : 7,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: isVertical ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 200 * index))
        .fadeIn(duration: 800.ms)
        .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0));
  }

  /// 构建层级详解标签页
  Widget _buildLayerDetailsTab(BuildContext context) {
    final layerDetails = [
      {
        'name': 'Petrel层',
        'description': '核心热更新引擎，提供热更新的核心功能和API接口',
        'features': ['热更新引擎', '核心API', '版本管理'],
        'color': Colors.purple
      },
      {
        'name': 'Base层',
        'description': '基础功能和服务层，提供通用的业务逻辑和工具服务',
        'features': ['基础服务', '工具类', '业务逻辑'],
        'color': Colors.indigo
      },
      {
        'name': 'Page层',
        'description': '页面层，包含所有需要支持热更新的页面和组件',
        'features': ['热更新支持', '动态加载', '页面管理'],
        'color': Colors.green
      },
      {
        'name': 'Flutter Web + Flutter Petrel',
        'description':
            'Flutter Web负责将代码编译成Web可执行的代码，Flutter Petrel负责拦截和展示热更新页面',
        'features': ['Web编译', '页面拦截', '动态展示'],
        'color': Colors.yellow
      },
      {
        'name': '插件层',
        'description': '原生插件层，用来实现原生插件调用部分，提供原生功能访问能力',
        'features': ['原生功能', '插件管理', '平台适配'],
        'color': Colors.orange
      },
      {
        'name': '原生App层',
        'description': '原生应用层，用于处理原生逻辑和系统级功能',
        'features': ['系统集成', '原生逻辑', '平台特性'],
        'color': Colors.red
      }
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < layerDetails.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildLayerDetailCard(context, layerDetails[i], i),
            ),
        ],
      ),
    );
  }

  /// 构建层级详情卡片
  Widget _buildLayerDetailCard(
      BuildContext context, Map<String, dynamic> layer, int index) {
    final color = layer['color'] as Color;

    return FloatingCard(
      duration: Duration(milliseconds: 2500 + index * 200),
      maxOffset: 4.0,
      shadowColor: color,
      child: GlassmorphismCard(
        blur: 15,
        opacity: 0.15,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // 左侧颜色标识
            Container(
              width: 6,
              height: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // 右侧内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    layer['name'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    layer['description'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          height: 1.5,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (layer['features'] as List<String>)
                        .map(
                          (feature) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: color.withOpacity(0.5)),
                            ),
                            child: Text(
                              feature,
                              style: TextStyle(
                                color: color,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 800.ms)
        .slideX(begin: 0.3, end: 0);
  }

  /// 构建技术栈标签页
  Widget _buildTechStackTab(BuildContext context) {
    final techStacks = [
      {
        'category': '前端技术',
        'technologies': [
          {'name': 'Flutter', 'icon': '🎯', 'color': Colors.blue},
          {'name': 'Dart', 'icon': '⚡', 'color': Colors.cyan},
          {'name': 'GetX', 'icon': '🚀', 'color': Colors.purple},
        ]
      },
      {
        'category': '架构模式',
        'technologies': [
          {'name': '六层架构', 'icon': '🏗️', 'color': Colors.orange},
          {'name': '微前端', 'icon': '🔧', 'color': Colors.green},
          {'name': '模块化', 'icon': '📦', 'color': Colors.indigo},
        ]
      },
      {
        'category': '热更新技术',
        'technologies': [
          {'name': '动态加载', 'icon': '🔄', 'color': Colors.red},
          {'name': '增量更新', 'icon': '📈', 'color': Colors.pink},
          {'name': '版本管理', 'icon': '📋', 'color': Colors.teal},
        ]
      }
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < techStacks.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildTechStackCategory(context, techStacks[i], i),
            ),
        ],
      ),
    );
  }

  /// 构建技术栈分类
  Widget _buildTechStackCategory(
      BuildContext context, Map<String, dynamic> category, int categoryIndex) {
    return GlassmorphismCard(
      blur: 15,
      opacity: 0.1,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category['category'],
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children:
                (category['technologies'] as List).asMap().entries.map((entry) {
              final tech = entry.value as Map<String, dynamic>;
              final index = entry.key;
              return _buildTechItem(context, tech, categoryIndex * 10 + index);
            }).toList(),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: 200 * categoryIndex))
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.2, end: 0);
  }

  /// 构建技术项
  Widget _buildTechItem(
      BuildContext context, Map<String, dynamic> tech, int index) {
    final color = tech['color'] as Color;

    return FloatingCard(
      duration: Duration(milliseconds: 2000 + index * 200),
      maxOffset: 4.0,
      shadowColor: color,
      child: Container(
        width: 100,
        height: 110, // 增加高度避免溢出
        child: GlassmorphismCard(
          blur: 15,
          opacity: 0.2,
          padding: const EdgeInsets.all(12), // 减少内边距
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // 使用最小尺寸
            children: [
              Flexible(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.9),
                        color.withOpacity(0.7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      tech['icon'],
                      style: const TextStyle(
                        fontSize: 20,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                    duration: 2000.ms,
                    delay: Duration(milliseconds: index * 300)),
              ),
              const SizedBox(height: 6), // 减少间距
              Flexible(
                child: Text(
                  tech['name'],
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 11, // 稍微减小字体
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 800.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  /// 构建热更新流程图
  Widget _buildUpdateFlowDiagram(BuildContext context) {
    // 定义流程步骤
    final steps = [
      {'title': '1. 版本检测', 'description': '应用启动时检查服务器是否有新版本'},
      {'title': '2. 资源下载', 'description': '按需下载更新包（支持断点续传）'},
      {'title': '3. 校验安装', 'description': '验证更新包完整性并解压安装'},
      {'title': '4. 动态加载', 'description': '运行时动态加载更新的模块'},
      {'title': '5. 热重载', 'description': '无需重启应用即可应用新功能'},
    ];

    return Responsive.isDesktop(context)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < steps.length; i++) ...[
                // 步骤卡片
                Expanded(
                  child: Column(
                    children: [
                      _buildFlowStepCard(context, steps[i], i),
                    ],
                  ),
                ),
                // 连接线（最后一个步骤不需要）
                if (i < steps.length - 1)
                  Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_right_alt,
                      color: Colors.blue.withOpacity(0.7),
                      size: 24,
                    ),
                  ),
              ],
            ],
          )
        : Column(
            children: [
              for (var i = 0; i < steps.length; i++) ...[
                // 步骤卡片
                _buildFlowStepCard(context, steps[i], i),
                // 连接线（最后一个步骤不需要）
                if (i < steps.length - 1)
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.blue.withOpacity(0.7),
                      size: 24,
                    ),
                  ),
              ],
            ],
          );
  }

  /// 构建单个流程步骤卡片
  Widget _buildFlowStepCard(
      BuildContext context, Map<String, String> step, int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];

    final color = colors[index % colors.length];

    return FloatingCard(
      duration: Duration(milliseconds: 2000 + index * 300),
      maxOffset: 4.0,
      shadowColor: color,
      child: GlassmorphismCard(
        blur: 10,
        opacity: 0.2,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.9),
              ),
              child: Center(
                child: Text(
                  step['title']?.split('.')[0] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                duration: 2000.ms, delay: Duration(milliseconds: index * 500)),
            const SizedBox(height: 16),
            Text(
              step['title']?.substring(2) ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              step['description'] ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.2, end: 0);
  }

  Widget _buildStatsSection(BuildContext context) {
    final stats = [
      {'number': '1K+', 'label': '下载量', 'icon': Icons.download},
      {'number': '100+', 'label': 'GitHub Stars', 'icon': Icons.star},
      {'number': '20+', 'label': '贡献者', 'icon': Icons.people},
      {'number': '95%', 'label': '更新成功率', 'icon': Icons.check_circle},
    ];

    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      child: Column(
        children: [
          const SizedBox(height: 60),
          GlassmorphismCard(
            blur: 10,
            opacity: 0.1,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              '📊 项目数据',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Responsive.getFontSize(context,
                        mobile: 28, tablet: 32, desktop: 36),
                  ),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(duration: 800.ms).scale(),
          const SizedBox(height: 60),
          Responsive.isDesktop(context)
              ? Row(
                  children: stats
                      .asMap()
                      .entries
                      .map((entry) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: _buildStatCard(
                                  context, entry.value, entry.key),
                            ),
                          ))
                      .toList(),
                )
              : Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: stats
                      .asMap()
                      .entries
                      .map((entry) => SizedBox(
                            width: (MediaQuery.of(context).size.width - 80) / 2,
                            child:
                                _buildStatCard(context, entry.value, entry.key),
                          ))
                      .toList(),
                ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context, Map<String, dynamic> stat, int index) {
    final colors = [
      const Color(0xFFE91E63),
      const Color(0xFF2196F3),
      const Color(0xFF4CAF50),
      const Color(0xFFFF9800),
    ];

    return FloatingCard(
      duration: Duration(milliseconds: 2500 + index * 300),
      maxOffset: 6.0,
      shadowColor: colors[index % colors.length],
      child: GlassmorphismCard(
        blur: 15,
        opacity: 0.15,
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Icon(
              stat['icon'],
              size: 40,
              color: colors[index % colors.length],
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                duration: 2000.ms, delay: Duration(milliseconds: index * 500)),
            const SizedBox(height: 16),
            Text(
              stat['number'],
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 32,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              stat['label'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.3, end: 0);
  }

  /// 构建层级架构图
  Widget _buildLayerDiagram(
      BuildContext context, String title, Color layerColor) {
    return Container(
      alignment: Alignment.center,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 背景圆环
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: layerColor.withOpacity(0.3),
                width: 15,
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                  begin: Offset(1.0, 1.0),
                  end: Offset(1.1, 1.1),
                  duration: 1500.ms)
              .then()
              .scale(
                  begin: Offset(1.1, 1.1),
                  end: Offset(1.0, 1.0),
                  duration: 1500.ms),
          // 中层圆环
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: layerColor.withOpacity(0.6),
                width: 10,
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                  begin: Offset(1.0, 1.0),
                  end: Offset(1.1, 1.1),
                  duration: 1500.ms,
                  delay: 300.ms)
              .then()
              .scale(
                  begin: Offset(1.1, 1.1),
                  end: Offset(1.0, 1.0),
                  duration: 1500.ms,
                  delay: 300.ms),
          // 中心圆环
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: layerColor.withOpacity(0.9),
            ),
            child: Center(
              child: Text(
                title.split('层')[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                  begin: Offset(1.0, 1.0),
                  end: Offset(1.1, 1.1),
                  duration: 1500.ms,
                  delay: 600.ms)
              .then()
              .scale(
                  begin: Offset(1.1, 1.1),
                  end: Offset(1.0, 1.0),
                  duration: 1500.ms,
                  delay: 600.ms),
          // 连接线和标签
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 1,
                  color: layerColor.withOpacity(0.5),
                ),
                const SizedBox(height: 8),
                Text(
                  title.contains('App基础层')
                      ? '原生交互'
                      : title.contains('Common公共层')
                          ? '服务封装'
                          : '动态模块',
                  style: TextStyle(
                    color: layerColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  title.contains('App基础层')
                      ? '平台隔离'
                      : title.contains('Common公共层')
                          ? '状态管理'
                          : '热更新包',
                  style: TextStyle(
                    color: layerColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 80,
                  height: 1,
                  color: layerColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection(BuildContext context) {
    // 热更新方案对比数据
    final comparisonData = [
      {
        'name': 'Petrel',
        'type': '动态Package加载',
        'principle': '六层架构+微前端思想',
        'pros': ['支持真正的页面级热更新', '架构清晰，模块解耦', '支持灰度发布与回滚', '跨平台兼容性好'],
        'cons': ['目前社区生态相对较新', '可能需要一定学习成本']
      },
      {
        'name': 'Fair',
        'type': 'JavaScript动态化',
        'principle': 'JSON/二进制+JavaScript层',
        'pros': ['动态化能力强', '支持多种热更新包格式', '58同城背书，社区活跃'],
        'cons': ['性能略低于原生Flutter', '复杂功能实现有局限性']
      },
      {
        'name': 'OTA Update',
        'type': '全量更新',
        'principle': '下载新版安装包',
        'pros': ['实现简单', '无需应用商店审核'],
        'cons': ['用户体验差', '更新包体积大', '需要用户手动安装']
      },
      {
        'name': 'Tinker',
        'type': '原生热修复',
        'principle': 'Android Native热修复',
        'pros': ['修复速度快', '无需重新安装'],
        'cons': ['仅支持Android', '不支持Flutter代码热更新']
      },
      {
        'name': 'MXFlutter',
        'type': 'JSON+布局引擎',
        'principle': '类似Fair的实现方案',
        'pros': ['轻量级', '易于集成'],
        'cons': ['功能受限', '性能相对较低']
      },
      {
        'name': 'Shorebird',
        'type': 'Flutter引擎修改',
        'principle': '修改Flutter引擎支持热更新',
        'pros': ['与原生Flutter性能一致', '支持所有Dart功能', '开源且社区发展快', '已支持iOS热更新'],
        'cons': ['需修改Flutter引擎', '需要特定的构建流程', '社区相对较小']
      }
    ];

    final colors = [
      const Color(0xFF00BCD4),
      const Color(0xFF9C27B0),
      const Color(0xFFFF5722),
      const Color(0xFF4CAF50),
      const Color(0xFF2196F3),
      const Color(0xFFF44336)
    ];

    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      child: Column(
        children: [
          const SizedBox(height: 80),

          // 标题
          GlassmorphismCard(
            blur: 10,
            opacity: 0.1,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              '🔍 热更新方案对比',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Responsive.getFontSize(context,
                        mobile: 28, tablet: 32, desktop: 36),
                  ),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(duration: 800.ms).scale(),

          const SizedBox(height: 60),

          // 对比卡片网格
          Responsive.isDesktop(context)
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: comparisonData.length,
                  itemBuilder: (context, index) => _buildComparisonCard(
                      context,
                      comparisonData[index],
                      colors[index % colors.length],
                      index),
                )
              : Column(
                  children: comparisonData
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _buildComparisonCard(context, entry.value,
                                colors[entry.key % colors.length], entry.key),
                          ))
                      .toList(),
                ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(
      BuildContext context, Map<String, dynamic> data, Color color, int index) {
    return FloatingCard(
      duration: Duration(milliseconds: 2500 + index * 300),
      maxOffset: 6.0,
      shadowColor: color,
      child: GlassmorphismCard(
        blur: 15,
        opacity: 0.15,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 方案名称
            Text(
              data['name'],
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),

            const SizedBox(height: 12),

            // 类型和原理
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '类型: ${data['type']}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '原理: ${data['principle']}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 优点
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '优点:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String pro in data['pros'])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const SizedBox(width: 24),
                            Text(
                              '• $pro',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 13,
                                  ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 缺点
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '缺点:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String con in data['cons'])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const SizedBox(width: 24),
                            Text(
                              '• $con',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 13,
                                  ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.getPadding(context),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            '© 2024 Petrel Hot Update. All rights reserved.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Made with ❤️ using Flutter & GetX',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

/// 自定义绘制器，用于绘制架构层之间的连接线
class ArchitectureConnectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 绘制连接线
    for (int i = 0; i < 5; i++) {
      final startX = 60.0 + (i * 80.0);
      final endX = 140.0 + (i * 80.0);
      final y = 40.0;

      // 绘制水平连接线
      canvas.drawLine(
        Offset(startX, y),
        Offset(endX, y),
        paint,
      );

      // 绘制箭头
      _drawArrow(canvas, Offset(endX, y), paint);
    }
  }

  void _drawArrow(Canvas canvas, Offset position, Paint paint) {
    final path = Path();
    path.moveTo(position.dx - 10, position.dy - 5);
    path.lineTo(position.dx, position.dy);
    path.lineTo(position.dx - 10, position.dy + 5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 自定义绘制器，用于绘制桌面端架构层之间的连接线
class DesktopArchitectureConnectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 绘制连接线
    for (int i = 0; i < 5; i++) {
      final startX = 20.0 + (i * 140.0);
      final endX = 20.0 + (i * 140.0) + 140.0;
      final y = 100.0;

      // 绘制水平连接线
      canvas.drawLine(
        Offset(startX, y),
        Offset(endX, y),
        paint,
      );

      // 绘制箭头
      _drawArrow(canvas, Offset(endX, y), paint);
    }
  }

  void _drawArrow(Canvas canvas, Offset position, Paint paint) {
    final path = Path();
    path.moveTo(position.dx - 10, position.dy - 5);
    path.lineTo(position.dx, position.dy);
    path.lineTo(position.dx - 10, position.dy + 5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 自定义绘制器，用于绘制移动端架构层之间的连接线
class MobileArchitectureConnectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 绘制连接线
    for (int i = 0; i < 5; i++) {
      final startX = 20.0;
      final endX = 20.0 + 140.0;
      final y = 20.0 + (i * 90.0);

      // 绘制垂直连接线
      canvas.drawLine(
        Offset(startX, y),
        Offset(endX, y),
        paint,
      );

      // 绘制箭头
      _drawArrow(canvas, Offset(endX, y), paint);
    }
  }

  void _drawArrow(Canvas canvas, Offset position, Paint paint) {
    final path = Path();
    path.moveTo(position.dx - 10, position.dy - 5);
    path.lineTo(position.dx, position.dy);
    path.lineTo(position.dx - 10, position.dy + 5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
