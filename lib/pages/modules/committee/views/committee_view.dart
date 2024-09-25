import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/committee_controller.dart';

class CommitteeView extends GetView<CommitteeController> {
  const CommitteeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommitteeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CommitteeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
