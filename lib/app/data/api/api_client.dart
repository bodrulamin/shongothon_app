import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shongothon/app/data/api/api_endpoints.dart';

class ApiClient extends GetConnect {
  var token;

  var box = GetStorage();
  var isLoading = false.obs;

  @override
  void onInit() {
    box = GetStorage();

    httpClient.baseUrl = 'https://s.alkhwarizmilab.com';
    httpClient.timeout = const Duration(seconds: 30);

    httpClient.addAuthenticator<dynamic>((request) async {
      print('====================== authenticator called ======================');
      setToken(request);

      return request;
    });

    httpClient.addRequestModifier<dynamic>((request) {
      print('====================== modifier called ======================');

      request.headers['Content-Security-Policy'] =
          'default-src \'self\'; frame-src \'self\' data:; script-src \'self\' \'unsafe-inline\' \'unsafe-eval\' https://storage.googleapis.com; style-src \'self\' https://fonts.googleapis.com \'unsafe-inline\'; img-src \'self\' data:; font-src \'self\' https://fonts.gstatic.com data:;';
      setToken(request);
      Get.showOverlay(
        asyncFunction: () async => request,
        loadingWidget: Center(child: CircularProgressIndicator()),
      );
      return request;
    });
    // Hide loading after response
    httpClient.addResponseModifier<dynamic>((request, response) {
      isLoading.value = false;
      return response;
    });

    httpClient.maxAuthRetries = 3;
  }

  void updateToken(String t) {
    token = t;
    box.write('token', t);
  }

  Request setToken(Request<dynamic> request) {
    List<String> excludedPaths = [Endpoints.authenticate, Endpoints.register];
    bool isExcluded =
        excludedPaths.any((path) => request.url.toString().contains(path));
    if (isExcluded) return request;

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    } else {
      token = box.read('token');
      request.headers['Authorization'] = 'Bearer $token';
    }
    request.headers['Authorization'] = 'Bearer $token';
    return request;
  }
}
