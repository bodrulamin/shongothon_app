import 'package:get/get.dart';
import 'package:shongothon/app/data/auth_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  var organizations = {}.obs;

  var currentIndex = 0.obs; // Observable list to store organization names  @override
  Future<void> onInit() async {
    await fetchData();
    super.onInit();

  }

  Future<void> fetchData() async {
    organizations.value = {}.obs;

    var response = await Get.find<ApiService>().fetchAccount();
    var account = response.body;
    var id = account['id'];
    
    Get.find<ApiService>().fetchUsergroups(id.toString()).then((response) {
      
      var userGroups = response.body.map((data) {
        var userGroupName = data['userGroup']['name'];
        var organizationName = data['userGroup']['organization']['name'];
        var organizationLogoUrl = data['userGroup']['organization']['logoUrl'];
        var branchName = data['userGroup']['branch']['name'];
    
        return {
          'userGroupName': userGroupName,
          'organizationName': organizationName,
          'organizationLogoUrl': organizationLogoUrl,
          'branchName': branchName,
          // 'parentBranchName': parentBranchName
        };
      }).toList();
      Map<String, Map<String, dynamic>> groupedData = {};
    
      for (var userGroup in userGroups) {
        var orgName = userGroup['organizationName'];
        var logoUrl = userGroup['organizationLogoUrl'];
        var branchName = userGroup['branchName'];
    
        if (!groupedData.containsKey(orgName)) {
          // If organization is not yet in the map, add it with logoUrl and an empty list of branches
          groupedData[orgName] = {
            "logoUrl": logoUrl,
            "branches": []
          };
        }
    
        // Add the branch name to the organization's branch list
        groupedData[orgName]?['branches'].add(branchName);
      }
    
      organizations.value = groupedData;
    
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
