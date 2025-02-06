import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient extends GetConnect {
  var token ;
  var box = GetStorage();
  var isLoading = false.obs;

  @override
  void onInit() {
    box = GetStorage();

    httpClient.baseUrl = 'https://s.alkhwarizmilab.com';
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.addAuthenticator<dynamic>((request) async {
      print("addAuthenticator called");
      if (token != null){
        request.headers['Authorization'] ='Bearer $token';
      } else {
        token = box.read('token');
        request.headers['Authorization'] ='Bearer $token';
      }
      return request;
    });
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Security-Policy'] = 'default-src \'self\'; frame-src \'self\' data:; script-src \'self\' \'unsafe-inline\' \'unsafe-eval\' https://storage.googleapis.com; style-src \'self\' https://fonts.googleapis.com \'unsafe-inline\'; img-src \'self\' data:; font-src \'self\' https://fonts.gstatic.com data:;';
      request.headers['Authorization'] ='Bearer $token';

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
  void updateToken(String t){
    token = t;
    box.write('token', t);

  }
}