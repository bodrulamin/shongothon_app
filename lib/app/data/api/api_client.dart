import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient extends GetConnect {
var token ;
  @override
  void onInit() {
    httpClient.baseUrl = 'https://s.alkhwarizmilab.com';
    httpClient.timeout = const Duration(seconds: 30);
    // httpClient.addAuthenticator<dynamic>((request) async {
    //   final response = await get("${httpClient.baseUrl}/api/authenticate");
    //   final token = response.body['id_token'];
    //   request.headers['Authorization'] = "$token";
    //   return request;
    // });

    httpClient.addRequestModifier<void>((request) {
      if (token != null){
        request.headers['Authorization'] ='Bearer $token';
      }
      request.headers['Content-Security-Policy'] = 'default-src \'self\'; frame-src \'self\' data:; script-src \'self\' \'unsafe-inline\' \'unsafe-eval\' https://storage.googleapis.com; style-src \'self\' https://fonts.googleapis.com \'unsafe-inline\'; img-src \'self\' data:; font-src \'self\' https://fonts.gstatic.com data:;';
      return request;
    });
    httpClient.maxAuthRetries = 3;

  }
  void updateToken(String t){
    token = t;
  }
}