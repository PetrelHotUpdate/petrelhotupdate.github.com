# 安装指南

## 系统要求

- Flutter SDK 3.1.3 或更高版本
- Dart SDK 3.1.3 或更高版本
- Android Studio / VS Code
- iOS开发需要Xcode（仅macOS）

## 安装步骤

### 1. 添加依赖

在您的 `pubspec.yaml` 文件中添加Petrel依赖：

```yaml
dependencies:
  petrel_hot_update: ^1.0.0
```

### 2. 安装依赖

运行以下命令安装依赖：

```bash
flutter pub get
```

### 3. 导入包

在您的Dart文件中导入Petrel：

```dart
import 'package:petrel_hot_update/petrel_hot_update.dart';
```

### 4. 初始化配置

在应用启动时初始化Petrel：

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化Petrel
  await Petrel.initialize(
    appId: 'your_app_id',
    serverUrl: 'https://your-server.com',
  );
  
  runApp(MyApp());
}
```

## 验证安装

运行以下命令验证安装是否成功：

```bash
flutter doctor
flutter run
```

如果一切正常，您应该能看到应用正常启动，并且控制台显示Petrel初始化成功的消息。

## 下一步

安装完成后，您可以：

1. 查看[快速上手](./quick-start.md)指南
2. 了解[基本概念](./basic-concepts.md)
3. 探索[API参考](../api-reference/core-api.md)

## 常见问题

### Q: 安装后出现版本冲突怎么办？
A: 请检查您的Flutter和Dart版本是否满足要求，必要时升级到最新版本。

### Q: 初始化失败怎么办？
A: 请检查网络连接和服务器配置，确保能够访问配置的服务器地址。

### Q: 支持哪些平台？
A: Petrel目前支持Android、iOS和Web平台，更多平台支持正在开发中。 