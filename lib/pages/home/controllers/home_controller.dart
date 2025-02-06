import 'package:get/get.dart';
import 'package:shongothon/app/data/api/api_service.dart';
import 'package:shongothon/app/data/model/allowed_branch.dart';
import 'package:shongothon/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

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
      if (response.body is List) {
        List<AllowedBranch> branchList = (response.body as List)
            .map((item) => AllowedBranch.fromJson(item))
            .toList();
        allowedBranches.value = branchList;
      } else {
        print("Unexpected response format: ${response.body}");
      }
    });    @override
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
    Get.toNamed(Routes.COMMITTEE_LIST);
  }
}
