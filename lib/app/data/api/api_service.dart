import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:shongothon/app/data/const.dart';
import 'package:shongothon/app/routes/app_pages.dart';

import 'api_client.dart';

class ApiService extends GetxService {
  final ApiClient apiClient;
  ApiService({required this.apiClient});
  final box = GetStorage();

  bool isSignedIn() {
    return box.read('token') != null; // Check if token exists
  }


  Future<void> signInWithUsernamePassword(String username, String password) async {
    final response = await apiClient.post(authenticate,{'username': username, 'password': password});

      if (response.statusCode == HttpStatus.ok) {
        var token = response.body['id_token'];
        box.write('token', token);
        apiClient.updateToken(token);
        Get.offAllNamed(Routes.HOME);
      } else {
        print('unauthorized');
        Get.snackbar('Error', 'Authentication unsuccessful');
        GFToast.showToast('text', Get.context!);
      }

    return Future.value('');
  }

  Future<Response> fetchMyBranches() async {

    final response = await apiClient.get(mybranches);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response; // Return the successful response
    }
  }
  Future<Response> fetchAccount() async {

    final response = await apiClient.get(account);

    // Handle response
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response; // Return the successful response
    }
  }
}
