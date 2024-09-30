import 'package:get/get.dart';
import 'package:shongothon/app/data/auth_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  var orgNames = [].obs; // Observable list to store organization names  @override
  void onInit() {
    super.onInit();
    Get.find<ApiService>().fetchOrganizations().then((response) {
      print(response.body);
      var names =
          response.body.map((org) => org['name']).toList();
      orgNames.value = names;
    });
  }

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
