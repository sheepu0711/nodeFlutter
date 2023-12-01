import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:doanalong/components/node_components.dart';
import 'package:doanalong/controller/controller_src.dart';
import 'package:doanalong/utils/util_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

part 'home_widget.dart';

class HomePage extends GetView<HomeCtrl> {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomeCtrl get controller => Get.find<HomeCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("Node ${controller.currentIndex.value + 1}")),
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
      bottomNavigationBar: _buildBottomNavigationBar(controller),
    );
  }
}
