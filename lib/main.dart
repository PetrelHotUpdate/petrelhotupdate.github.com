import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: "海燕Flutter热更新",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
