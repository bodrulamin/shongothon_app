import 'package:get/get.dart';
import 'package:shongothon/app/data/api/api_service.dart';
import 'package:shongothon/app/data/model/allowed_branch.dart';
import 'package:shongothon/app/routes/app_pages.dart';

import '../../../app/data/model/branch.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  var allowedBranches = <AllowedBranch>[].obs;
  var currentIndex = 0
      .obs; // Observable list to store organization names  @override
  Future<void> onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    allowedBranches.value = [];

    Get.find<ApiService>().fetchMyBranches().then((response) {
        allowedBranches.value = response;
    });
    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {
      super.onClose();
    }

    void increment() => count.value++;
  }

  onBranchTap(Branch branch) {
    print("object");
    Get.toNamed(
        Routes.COMMITTEE_LIST,
        arguments: branch);
  }
}
