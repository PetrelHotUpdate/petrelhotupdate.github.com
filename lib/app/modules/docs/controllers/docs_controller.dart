import 'package:get/get.dart';
import '../models/doc_item.dart';
import '../services/docs_service.dart';

class DocsController extends GetxController {
  final DocsService _docsService = DocsService();

  final RxList<DocItem> docs = <DocItem>[].obs;
  final Rx<DocItem?> currentDoc = Rx<DocItem?>(null);
  final RxString currentContent = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<DocItem> breadcrumb = <DocItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDocs();
  }

  /// 加载文档配置
  Future<void> loadDocs() async {
    isLoading.value = true;
    try {
      final docsList = await _docsService.getDocs();
      docs.assignAll(docsList);

      // 默认显示第一个文档
      if (docs.isNotEmpty && docs.first.hasChildren) {
        final firstChild = docs.first.children.first;
        await loadDocument(firstChild);
      }
    } catch (e) {
      print('Error loading docs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// 加载指定文档
  Future<void> loadDocument(DocItem doc) async {
    if (!doc.isFile) return;

    isLoading.value = true;
    try {
      currentDoc.value = doc;

      // 获取文档内容
      final content = await _docsService.getMarkdownContent(doc.file!);
      currentContent.value = content ?? '文档内容加载失败';

      // 更新面包屑
      updateBreadcrumb(doc);
    } catch (e) {
      print('Error loading document: $e');
      currentContent.value = '文档加载失败: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// 更新面包屑导航
  void updateBreadcrumb(DocItem doc) {
    breadcrumb.clear();
    final path = _docsService.getDocPath(doc.id, docs);
    breadcrumb.addAll(path);
  }

  /// 展开/折叠目录
  void toggleDirectory(DocItem doc) {
    // 这里可以添加展开/折叠逻辑
    // 暂时只是重新加载文档
    if (doc.isFile) {
      loadDocument(doc);
    }
  }

  /// 搜索文档
  List<DocItem> searchDocs(String query) {
    if (query.isEmpty) return docs;

    final results = <DocItem>[];
    _searchInDocs(docs, query.toLowerCase(), results);
    return results;
  }

  void _searchInDocs(List<DocItem> docs, String query, List<DocItem> results) {
    for (final doc in docs) {
      if (doc.title.toLowerCase().contains(query)) {
        results.add(doc);
      }
      if (doc.hasChildren) {
        _searchInDocs(doc.children, query, results);
      }
    }
  }

  /// 刷新文档
  Future<void> refreshDocs() async {
    _docsService.clearCache();
    await loadDocs();
  }
}
