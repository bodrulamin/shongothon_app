import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shongothon/app/data/model/committee.dart';
import 'package:shongothon/app/routes/app_pages.dart';

import '../../../app/data/api/api_service.dart';
import '../../../app/data/model/branch.dart';

class CommitteeListController extends GetxController {
  final count = 0.obs;
  var branch = Rxn<Branch>();
  var committeeList = Rxn<List<Committee>>();

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) {
      branch.value = Get.arguments;
      var branchId = branch.value?.id.toString();
      fetchBranchInfo(branchId!);
      fetchCommitteeByBranchId(branchId);
    } else {
        Get.toNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchCommitteeByBranchId(String branchId) {
    Get.find<ApiService>().fetchCommittees(branchId).then((response) {
      committeeList.value = response;
    });
  }

  void fetchBranchInfo(String branchId) {
    Get.find<ApiService>().fetchBranch(branchId).then((response) {
      branch.value = response;
    });
  }
}
