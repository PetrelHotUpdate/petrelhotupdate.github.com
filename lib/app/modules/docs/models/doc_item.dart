class DocItem {
  final String id;
  final String title;
  final String? icon;
  final int order;
  final String? file;
  final List<DocItem> children;

  DocItem({
    required this.id,
    required this.title,
    this.icon,
    required this.order,
    this.file,
    this.children = const [],
  });

  factory DocItem.fromJson(Map<String, dynamic> json) {
    return DocItem(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String?,
      order: json['order'] as int,
      file: json['file'] as String?,
      children: (json['children'] as List<dynamic>?)
              ?.map((child) => DocItem.fromJson(child as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'order': order,
      'file': file,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  bool get hasChildren => children.isNotEmpty;
  bool get isFile => file != null;
  bool get isDirectory => file == null;

  @override
  String toString() {
    return 'DocItem(id: $id, title: $title, children: ${children.length})';
  }
}
