import 'package:node_flutter/routes/routes.dart';
import 'package:node_flutter/utils/utils_src.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MqttCtrl extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController mqttUrl = TextEditingController()
    ..text = 'Mqtt.mysignage.vn';

  final TextEditingController mqttPort = TextEditingController()..text = '1883';

  final TextEditingController mqttUsername = TextEditingController();

  final TextEditingController mqttPassword = TextEditingController();

  final TextEditingController mqttTopic = TextEditingController()
    ..text = 'huong';

  void saveMqtt() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    BoxStorage.setBoxUrl(mqttUrl.text.trim());

    BoxStorage.setBoxPort(mqttPort.text.trim());

    BoxStorage.setBoxUsername(mqttUsername.text.trim());

    BoxStorage.setBoxPassword(mqttPassword.text.trim());

    BoxStorage.setBoxTopic(mqttTopic.text.trim());

    BoxStorage.setHaveMqtt(true);

    Get.offNamed(Routes.home);
  }
}
