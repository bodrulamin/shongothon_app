import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shongothon/app/data/auth_service.dart';
import 'package:shongothon/app/routes/app_pages.dart';

FutureOr<void> main() async {
  Get.put(ApiService());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
