import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/doc_item.dart';

class DocsService {
  static const String _configPath = 'assets/docs/docs_config.json';

  List<DocItem>? _docs;

  /// 获取文档配置
  Future<List<DocItem>> getDocs() async {
    if (_docs != null) return _docs!;

    try {
      final String configString = await rootBundle.loadString(_configPath);
      final Map<String, dynamic> config = json.decode(configString);

      _docs = (config['docs'] as List<dynamic>)
          .map((doc) => DocItem.fromJson(doc as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => a.order.compareTo(b.order));

      return _docs!;
    } catch (e) {
      print('Error loading docs config: $e');
      return [];
    }
  }

  /// 获取指定文件的Markdown内容
  Future<String?> getMarkdownContent(String filePath) async {
    try {
      final String content =
          await rootBundle.loadString('assets/docs/$filePath');
      return content;
    } catch (e) {
      print('Error loading markdown file $filePath: $e');
      return null;
    }
  }

  /// 根据ID查找文档项
  DocItem? findDocById(String id, List<DocItem> docs) {
    for (final doc in docs) {
      if (doc.id == id) return doc;
      if (doc.hasChildren) {
        final found = findDocById(id, doc.children);
        if (found != null) return found;
      }
    }
    return null;
  }

  /// 获取文档的完整路径
  List<DocItem> getDocPath(String id, List<DocItem> docs) {
    final path = <DocItem>[];
    _findPath(id, docs, path);
    return path;
  }

  bool _findPath(String id, List<DocItem> docs, List<DocItem> path) {
    for (final doc in docs) {
      path.add(doc);
      if (doc.id == id) return true;
      if (doc.hasChildren && _findPath(id, doc.children, path)) {
        return true;
      }
      path.removeLast();
    }
    return false;
  }

  /// 清除缓存
  void clearCache() {
    _docs = null;
  }
}
