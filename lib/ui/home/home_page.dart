import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodeflutter/controller/controller_src.dart';
import 'package:nodeflutter/routes/routes.dart';
import 'package:nodeflutter/utils/util_widget.dart';

part 'home_widget.dart';

class HomePage extends GetView<HomeCtrl> {
  const HomePage({super.key});

  @override
  HomeCtrl get controller => Get.find<HomeCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi Node"),
        centerTitle: true,
        backgroundColor: Colors.blue.withOpacity(0.4),
        actions: [
          IconButton(
            onPressed: () {
              controller.showAlert();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildBody(controller),
      extendBody: true,
    );
  }
}
