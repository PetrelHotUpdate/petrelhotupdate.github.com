import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:web_site/gen/assets.gen.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: Assets.images.petrel.image(
                  width: 200,
                  height: 200,
                ),
              ),
              const TDText(
                '海燕（Petrel）',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 30),
              const TDText('Flutter热更新框架（基于Flutter Web的热更新技术）'),
              const SizedBox(height: 30),
              TDButton(
                text: '前往官网',
                onTap: () => controller.goToWebSite(),
              ),
              const SizedBox(height: 20),
              const TDDivider(),
              TDTabBar(
                tabs: const [
                  TDTab(
                    text: '①工程要求',
                  ),
                  TDTab(
                    text: '②演示说明',
                  )
                ],
                controller: controller.tabController,
              ),
              Expanded(
                child: TDTabBarView(
                  controller: controller.tabController,
                  children: [
                    _buildTabView1(),
                    Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabView1() {
    return const TDText('''
海燕热更新要求将目标工程进行分解为三层架构:
App(基础层):
  这一层包含所有只支持对应平台的代码和插件，比如iOS和安卓平台。这一层的代码变动较少，如果这一层代码变动则只能发布App解决。
Common(公共层)
  这一层所有的公共能力都在这一层提供，比如公共组件，公共方法，请求，储存等等，这一层要求支持编译到全平台
Page（页面层）
  这一层将页面分为了若干个Package，每隔Package都依赖于Common层，都可以单独在Web进行编译。
''');
  }
}
