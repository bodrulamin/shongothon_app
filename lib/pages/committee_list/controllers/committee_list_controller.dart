import 'package:get/get.dart';
import 'package:shongothon/app/data/model/committee.dart';

import '../../../app/data/api/api_service.dart';
import '../../../app/data/model/allowed_branch.dart';
import '../../../app/data/model/branch.dart';

class CommitteeListController extends GetxController {
  final count = 0.obs;
  var branch = Rxn<Branch>();
  var committeeList = Rxn<List<Committee>>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      branch.value = Get.arguments;
    } else {
      var branchId = Get.parameters['branchId'];
      if (branchId != null) {
        fetchBranchInfo(branchId);
        fetchCommitteeByBranchId(branchId);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
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
