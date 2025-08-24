import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../controllers/docs_controller.dart';
import '../models/doc_item.dart';
import '../../../core/utils/responsive.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/markdown_viewer.dart';

class DocsView extends GetView<DocsController> {
  const DocsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧菜单
          if (Responsive.isDesktop(context))
            SizedBox(
              width: 280,
              child: SidebarMenu(
                onDocSelected: controller.loadDocument,
              ),
            ),

          // 右侧内容区域
          Expanded(
            child: Column(
              children: [
                // 顶部导航栏（移动端显示）
                if (Responsive.isMobile(context)) _buildMobileHeader(context),

                // 面包屑导航
                _buildBreadcrumb(context),

                // 文档内容
                Expanded(
                  child: _buildContent(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showMobileMenu(context),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '文档',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb(BuildContext context) {
    return Obx(() {
      if (controller.breadcrumb.isEmpty) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.home,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(width: 8),
            ...controller.breadcrumb.asMap().entries.map((entry) {
              final index = entry.key;
              final doc = entry.value;
              final isLast = index == controller.breadcrumb.length - 1;

              return Row(
                children: [
                  if (index > 0) ...[
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4),
                    ),
                    const SizedBox(width: 8),
                  ],
                  GestureDetector(
                    onTap: isLast ? null : () => controller.loadDocument(doc),
                    child: Text(
                      doc.title,
                      style: TextStyle(
                        color: isLast
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                        fontWeight:
                            isLast ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      );
    });
  }

  Widget _buildContent(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.currentDoc.value == null) {
        return const Center(
          child: Text('请选择一个文档'),
        );
      }

      return MarkdownViewer(
        content: controller.currentContent.value,
        title: controller.currentDoc.value!.title,
      );
    });
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SidebarMenu(
                  onDocSelected: (doc) {
                    Navigator.pop(context);
                    controller.loadDocument(doc);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('搜索文档'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '输入关键词搜索...',
            border: OutlineInputBorder(),
          ),
          onChanged: (query) {
            // 实现搜索逻辑
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('搜索'),
          ),
        ],
      ),
    );
  }
}
