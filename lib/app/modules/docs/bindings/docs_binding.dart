import 'package:get/get.dart';
import '../controllers/docs_controller.dart';

class DocsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocsController>(
      () => DocsController(),
    );
  }
}
