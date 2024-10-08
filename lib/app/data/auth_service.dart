import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
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
        GFToast.showToast('text', Get.context!);
      }
    });
    return Future.value('');
  }

  Future<Response> fetchUsergroups(String userId) async {
    final token = box.read('token');
    if (token != null) {
      httpClient.addRequestModifier((Request request) {
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Security-Policy'] = 'default-src \'self\'; frame-src \'self\' data:; script-src \'self\' \'unsafe-inline\' \'unsafe-eval\' https://storage.googleapis.com; style-src \'self\' https://fonts.googleapis.com \'unsafe-inline\'; img-src \'self\' data:; font-src \'self\' https://fonts.gstatic.com data:;';
        return request;
      });
    }
    final response = await get(mygroup,query: {'userId.equals':userId});
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response; // Return the successful response
    }
  }
  Future<Response> fetchAccount() async {
    final token = box.read('token');
    if (token != null) {
      httpClient.addRequestModifier((Request request) {
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Security-Policy'] = 'default-src \'self\'; frame-src \'self\' data:; script-src \'self\' \'unsafe-inline\' \'unsafe-eval\' https://storage.googleapis.com; style-src \'self\' https://fonts.googleapis.com \'unsafe-inline\'; img-src \'self\' data:; font-src \'self\' https://fonts.gstatic.com data:;';
        return request;
      });
    }

    final response = await get(account);

    // Handle response
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response; // Return the successful response
    }
  }
}
