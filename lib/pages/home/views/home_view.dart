import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shongothon/flavors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(F.title),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() =>
            Column(children: controller.orgNames.map((f) => Text(f)).toList())),
      ),
    );
  }
}
