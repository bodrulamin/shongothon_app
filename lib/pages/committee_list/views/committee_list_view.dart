import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/committee_list_controller.dart';

class CommitteeListView extends GetView<CommitteeListController> {
  const CommitteeListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Obx(()=> controller.branch.value != null ? Text(controller.branch.value!.name) :  Text('alksdjlfjasd') ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CommitteeListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
