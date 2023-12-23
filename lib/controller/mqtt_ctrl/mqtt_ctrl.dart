import 'package:node_flutter/routes/routes.dart';
import 'package:node_flutter/utils/utils_src.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MqttCtrl extends GetxController {
  // Kiểm tra xem người dùng đã nhập dữ liệu hay chưa
  final formKeyUrl = GlobalKey<FormState>();
  final formKeyTopic = GlobalKey<FormState>();

  // Khai báo url, port, username, password, topic
  final TextEditingController mqttUrl = TextEditingController()
    ..text = 'Mqtt.mysignage.vn';

  final TextEditingController mqttPort = TextEditingController()..text = '1883';

  final TextEditingController mqttUsername = TextEditingController();

  final TextEditingController mqttPassword = TextEditingController();

  final TextEditingController mqttTopic = TextEditingController()
    ..text = 'huong';

  void saveMqtt() {
    // Kiểm tra xem người dùng đã nhập dữ liệu hay chưa
    if (!formKeyUrl.currentState!.validate() ||
        !formKeyTopic.currentState!.validate()) {
      return;
    }
    // Lưu các dữ liệu vào bộ nhớ máy
    BoxStorage.setBoxUrl(mqttUrl.text.trim());

    BoxStorage.setBoxPort(mqttPort.text.trim());

    BoxStorage.setBoxUsername(mqttUsername.text.trim());

    BoxStorage.setBoxPassword(mqttPassword.text.trim());

    BoxStorage.setBoxTopic(mqttTopic.text.trim());

    BoxStorage.setHaveMqtt(true);

    // Chuyển sang màn hình Home
    Get.offNamed(Routes.home);
  }
}
