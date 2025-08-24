import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final RxInt currentTabIndex = 0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // 导航到GitHub
  Future<void> goToGitHub() async {
    await _launchUrl(AppConstants.githubUrl);
  }

  // 导航到文档页面
  void goToDocs() {
    Get.toNamed(Routes.DOCS);
  }

  // 导航到演示页面
  Future<void> goToDemo() async {
    await _launchUrl(AppConstants.demoUrl);
  }

  // 启动URL
  Future<void> _launchUrl(String url) async {
    isLoading.value = true;
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          '错误',
          '无法打开链接: $url',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        '错误',
        '打开链接时发生错误: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // 复制代码到剪贴板
  void copyToClipboard(String text) {
    // 这里可以添加复制到剪贴板的功能
    Get.snackbar(
      '成功',
      '代码已复制到剪贴板',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
