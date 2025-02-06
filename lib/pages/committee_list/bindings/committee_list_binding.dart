import 'package:get/get.dart';

import '../controllers/committee_list_controller.dart';

class CommitteeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommitteeListController>(
      () => CommitteeListController(),
    );
  }
}
