import 'package:get/get.dart';

import '../controllers/committee_controller.dart';

class CommitteeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommitteeController>(
      () => CommitteeController(),
    );
  }
}
