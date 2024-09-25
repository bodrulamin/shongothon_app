import 'package:get/get.dart';

import '../controllers/module_list_controller.dart';

class ModuleListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModuleListController>(
      () => ModuleListController(),
    );
  }
}
