import 'package:nodeflutter/controller/controller_src.dart';
import 'package:nodeflutter/utils/utils_src.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MqttPage extends GetView<MqttCtrl> {
  const MqttPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SafeArea(
              bottom: true,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text('MQTT'),
                    ),
                    sdsSizedBox10,
                    Form(
                      key: controller.formKeyUrl,
                      child: _buildTextFields(
                        title: "Địa chỉ Url",
                        isValidate: true,
                        controller: controller.mqttUrl,
                      ),
                    ),
                    _buildTextFields(
                      title: "Port",
                      controller: controller.mqttPort,
                    ),
                    _buildTextFields(
                      title: "Tên đăng nhập",
                      controller: controller.mqttUsername,
                    ),
                    _buildTextFields(
                      title: "Mật khẩu",
                      controller: controller.mqttPassword,
                    ),
                    Form(
                      key: controller.formKeyTopic,
                      child: _buildTextFields(
                        title: "Topic",
                        isValidate: true,
                        controller: controller.mqttTopic,
                      ),
                    ),
                    sdsSizedBox10,
                    ElevatedButton(
                      onPressed: () {
                        controller.saveMqtt();
                      },
                      child: const Text('Start Connect'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields({
    required String title,
    bool isValidate = false,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: Get.width * 0.8,
      height: Get.height * 0.1,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (isValidate == true && (value == null || value.isEmpty)) {
            return 'Xin hãy nhập nội dung';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
