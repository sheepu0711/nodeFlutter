import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:node_flutter/components/node_components.dart';
import 'package:node_flutter/controller/controller_src.dart';
import 'package:node_flutter/utils/util_widget.dart';

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
