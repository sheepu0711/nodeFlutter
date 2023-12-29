import 'package:nodeflutter/controller/controller_src.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/model_src.dart';

class NodeComponent {
  static const Map<int, String> iconData = {
    0: "assets/svg/temperature.svg",
    1: "assets/svg/humidity.svg",
    2: "assets/svg/uv.svg",
    3: "assets/svg/dust.svg",
    4: "assets/svg/cacbon.svg",
  };
  static Widget showDialog(HomeCtrl controller) {
    return AlertDialog(
      title: const Text('Thông báo'),
      content: const Text('Bạn có muốn đăng xuất không?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Không'),
        ),
        TextButton(
          onPressed: () {
            controller.logOut();
          },
          child: const Text('Có'),
        ),
      ],
    );
  }


  static String getLastValue(DataModel dataMqtt, int index) {
    switch (index) {
      case 0:
        return dataMqtt.data?.temp ?? '0';
      case 1:
        return dataMqtt.data?.humi ?? '0';
      case 2:
        return dataMqtt.data?.uv ?? '0';
      case 3:
        return dataMqtt.data?.dust ?? '0';
      case 4:
        return dataMqtt.data?.co2 ?? '0';
      default:
        return dataMqtt.data?.temp ?? '0';
    }
  }
}
