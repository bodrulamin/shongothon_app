import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shongothon/app/data/const.dart';
import 'package:shongothon/app/routes/app_pages.dart';

class ApiService extends GetConnect {
  final box = GetStorage();

  bool isSignedIn() {
    return box.read('token') != null; // Check if token exists
  }

  Future<Response> postUser(Map data) => post(authenticate, data);

  Future<void> signInWithUsernamePassword(String username, String password) async {
    await postUser({'username': username, 'password': password}).then((response) {
      if (response.statusCode == HttpStatus.ok) {
        var token = response.body['id_token'];
        box.write('token', token);
        httpClient.addRequestModifier((Request request) {
          request.headers['Authorization'] = 'Bearer $token';
          return request;
        });
        Get.offAllNamed(Routes.HOME);
      } else {
        print('unauthorized');
        Get.snackbar('Error', 'Authentication unsuccessful');
      }
    });
    return Future.value('');
  }

  Future<Response> fetchOrganizations() async {
    // Read the token from storage
    final token = box.read('token');

    // Set the authorization header
    if (token != null) {
      // Add token to headers
      httpClient.addRequestModifier((Request request) {
        request.headers['Authorization'] = 'Bearer $token';
        return request;
      });
    }

    // Make the GET request
    final response = await get(organizations);

    // Handle response
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response; // Return the successful response
    }
  }
}
