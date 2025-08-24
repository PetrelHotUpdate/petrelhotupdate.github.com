import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class MarkdownViewer extends StatelessWidget {
  final String content;
  final String title;

  const MarkdownViewer({
    super.key,
    required this.content,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.getPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),

          const SizedBox(height: 24),

          // 内容
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: _buildMarkdownContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkdownContent(BuildContext context) {
    // 简单的Markdown解析器
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      if (line.isEmpty) {
        widgets.add(const SizedBox(height: 16));
        continue;
      }

      if (line.startsWith('# ')) {
        // H1 标题
        widgets.add(
          Text(
            line.substring(2),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        );
        widgets.add(const SizedBox(height: 16));
      } else if (line.startsWith('## ')) {
        // H2 标题
        widgets.add(
          Text(
            line.substring(3),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        );
        widgets.add(const SizedBox(height: 12));
      } else if (line.startsWith('### ')) {
        // H3 标题
        widgets.add(
          Text(
            line.substring(4),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        );
        widgets.add(const SizedBox(height: 8));
      } else if (line.startsWith('- ') || line.startsWith('* ')) {
        // 列表项
        widgets.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Text(
                  line.substring(2),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                ),
              ),
            ],
          ),
        );
        widgets.add(const SizedBox(height: 4));
      } else if (line.startsWith('```')) {
        // 代码块
        final codeBlock = <String>[];
        int j = i + 1;
        while (j < lines.length && !lines[j].startsWith('```')) {
          codeBlock.add(lines[j]);
          j++;
        }
        i = j;

        if (codeBlock.isNotEmpty) {
          widgets.add(
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: codeBlock
                    .map(
                      (codeLine) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          codeLine,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'monospace',
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(0.3),
                                  ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
          widgets.add(const SizedBox(height: 16));
        }
      } else if (line.startsWith('`') && line.endsWith('`')) {
        // 行内代码
        widgets.add(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              line.substring(1, line.length - 1),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        );
        widgets.add(const SizedBox(height: 8));
      } else if (line.startsWith('[') &&
          line.contains('](') &&
          line.endsWith(')')) {
        // 链接
        final linkMatch = RegExp(r'\[([^\]]+)\]\(([^)]+)\)').firstMatch(line);
        if (linkMatch != null) {
          final linkText = linkMatch.group(1);
          final linkUrl = linkMatch.group(2);
          widgets.add(
            GestureDetector(
              onTap: () {
                // 处理链接点击
                print('Link clicked: $linkUrl');
              },
              child: Text(
                linkText!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
          widgets.add(const SizedBox(height: 8));
        }
      } else {
        // 普通文本
        widgets.add(
          Text(
            line,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                ),
          ),
        );
        widgets.add(const SizedBox(height: 8));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
