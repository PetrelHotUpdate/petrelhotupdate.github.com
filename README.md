# Petrel（海燕）Flutter热更新框架官网

![Petrel Logo](assets/images/petrel.png)

## 🌟 项目简介

Petrel（海燕）是一个基于Flutter Web的热更新框架，让你的Flutter应用支持动态更新。本项目是Petrel框架的官方网站，使用Flutter Web + GetX构建。

## 🚀 特性

- ✨ 现代化的响应式设计
- 🎨 优雅的动画效果
- 📱 完美的移动端适配
- ⚡ 基于GetX的状态管理
- 🌐 SEO友好的Web配置
- 📚 完整的文档系统

## 🏗️ 技术栈

- **Flutter Web** - 跨平台UI框架
- **GetX** - 状态管理和路由管理
- **TDesign Flutter** - UI组件库
- **Google Fonts** - 字体支持
- **Flutter Animate** - 动画效果

## 📦 安装和运行

### 环境要求

- Flutter SDK >= 3.1.3
- Dart SDK >= 3.1.3

### 本地开发

```bash
# 克隆项目
git clone https://github.com/PetrelHotUpdate/petrelhotupdate.github.com.git

# 进入项目目录
cd petrelhotupdate.github.com

# 安装依赖
flutter pub get

# 生成资源文件
flutter packages pub run flutter_gen

# 运行项目
flutter run -d chrome
```

### 构建生产版本

```bash
# 使用构建脚本
./scripts/build_web.sh

# 或者手动构建
flutter build web --release --web-renderer html
```

## 📁 项目结构

```
lib/
├── app/
│   ├── core/                 # 核心功能
│   │   ├── constants/        # 常量定义
│   │   ├── theme/           # 主题配置
│   │   └── utils/           # 工具类
│   ├── modules/             # 功能模块
│   │   ├── home/           # 首页模块
│   │   └── docs/           # 文档模块
│   └── routes/             # 路由配置
├── gen/                    # 生成的文件
└── main.dart              # 应用入口
```

## 🎯 核心功能

### 三层架构设计

1. **App基础层**: 包含平台特定代码和插件
2. **Common公共层**: 提供公共组件和工具
3. **Page页面层**: 独立的页面模块，支持热更新

### 响应式设计

- 移动端优先的设计理念
- 自适应不同屏幕尺寸
- 优化的触摸交互体验

### 性能优化

- 懒加载路由
- 图片优化
- Web性能优化
- SEO友好配置

## 🔧 配置说明

### 主题配置

在 `lib/app/core/theme/app_theme.dart` 中可以自定义应用主题：

```dart
static const Color primaryColor = Color(0xFF1976D2);
static const Color secondaryColor = Color(0xFF03DAC6);
```

### 常量配置

在 `lib/app/core/constants/app_constants.dart` 中配置应用常量：

```dart
static const String appName = 'Petrel（海燕）';
static const String githubUrl = 'https://github.com/PetrelHotUpdate/petrel_app_example';
```

## 🚀 部署

### GitHub Pages

项目配置了GitHub Actions自动部署到GitHub Pages：

1. 推送代码到main分支
2. GitHub Actions自动构建
3. 部署到 `https://petrelhotupdate.github.io`

### 自定义部署

```bash
# 构建项目
flutter build web --release

# 将build/web目录部署到你的服务器
```

## 🤝 贡献指南

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🔗 相关链接

- [Petrel框架源码](https://github.com/PetrelHotUpdate/petrel_app_example)
- [在线文档](https://petrelhotupdate.github.io/docs)
- [在线演示](https://petrelhotupdate.github.io/demo)

## 📞 联系我们

如果你有任何问题或建议，欢迎通过以下方式联系我们：

- 提交 [Issue](https://github.com/PetrelHotUpdate/petrelhotupdate.github.com/issues)
- 发起 [Discussion](https://github.com/PetrelHotUpdate/petrelhotupdate.github.com/discussions)

---

Made with ❤️ by Petrel Team