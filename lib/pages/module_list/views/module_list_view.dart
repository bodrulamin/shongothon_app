import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/module_list_controller.dart';

class ModuleListView extends GetView<ModuleListController> {
  const ModuleListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ModuleListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ModuleListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
