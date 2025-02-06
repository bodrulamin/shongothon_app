import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:shongothon/app/data/api/api_endpoints.dart';
import 'package:shongothon/app/data/model/branch.dart';
import 'package:shongothon/app/routes/app_pages.dart';

import '../model/allowed_branch.dart';
import '../model/committee.dart';
import 'api_client.dart';

class ApiService extends GetxService {
  final ApiClient apiClient;

  ApiService({required this.apiClient});

  final box = GetStorage();

  bool isSignedIn() {
    return box.read('token') != null; // Check if token exists
  }

  Future<void> signInWithUsernamePassword(
      String username, String password) async {
    final response = await apiClient.post(
        Endpoints.authenticate, {'username': username, 'password': password});

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

  Future<List<AllowedBranch>> fetchMyBranches() async {
    final response = await apiClient.get(Endpoints.myBranches);
    return response.status.hasError
        ? []
        : (response.body as List).map((item) => AllowedBranch.fromJson(item)).toList();
  }

  Future<Response> fetchAccount() async {
    final response = await apiClient.get(Endpoints.account);

    // Handle response
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response; // Return the successful response
    }
  }

  Future<List<Committee>> fetchCommittees(String branchId) async {
    final response =
        await apiClient.get(Endpoints.committee, query: {'branchId': branchId});
    return response.status.hasError
        ? []
        : (response.body as List)
            .map((item) => Committee.fromJson(item))
            .toList();
  }

  Future<Branch?> fetchBranch(String branchId) async {
    final response =
        await apiClient.get(Endpoints.committee, query: {'branchId': branchId});

    return response.status.hasError ? null : Branch.fromJson(response.body);
  }
}
