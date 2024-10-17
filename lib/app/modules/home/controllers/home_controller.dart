import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  goToWebSite() {
    launchUrl(
        Uri.parse('https://github.com/PetrelHotUpdate/petrel_app_example'));
  }
}
