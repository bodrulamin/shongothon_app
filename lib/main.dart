import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shongothon/app/data/api/api_service.dart';
import 'package:shongothon/app/routes/app_pages.dart';

import 'app/data/api/api_client.dart';

FutureOr<void> main() async {
  await GetStorage.init();
  Get.lazyPut(() => ApiClient());
  Get.lazyPut(() => ApiService(apiClient: Get.find()));
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
