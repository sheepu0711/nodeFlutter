import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:nodeflutter/components/node_components.dart';
import 'package:nodeflutter/controller/node_ctrl/node_ctrl.dart';
import 'package:nodeflutter/model/model_src.dart';
import 'package:nodeflutter/routes/routes.dart';
import 'package:nodeflutter/utils/fake_data.dart';
import 'package:nodeflutter/utils/utils_src.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeCtrl extends GetxController {
  final client = MqttServerClient(BoxStorage.boxUrl, '');

  late final WebSocketChannel? channel;

  late String url;

  final RxInt currentIndex = 0.obs;

  RxBool isLoading = false.obs;

  RxList<DataModel> dataModel = <DataModel>[].obs;

  RxBool isConnected = false.obs;

  RxBool ifOffline = false.obs;

  @override
  void onInit() async {
    await connect();
    super.onInit();
  }

  Future<void> connect() async {
    client.port = int.parse(BoxStorage.boxPort);
    // client.logging(on: true);
    client.secure = false;
    client.keepAlivePeriod = 20;
    client.connectTimeoutPeriod = 2000;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    final connMess = MqttConnectMessage()
        .withClientIdentifier(DateTime.now().millisecondsSinceEpoch.toString())
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;
    isLoading.value = true;
    try {
      await client.connect(BoxStorage.boxUsername, BoxStorage.boxPassword);
    } on NoConnectionException catch (e) {
      logger.i('client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      logger.i('EXAMPLE::socket exception - $e');
      client.disconnect();
    }
  }

  void onConnected() {
    logger.i('Connected');
    Get.showSnackbar(const GetSnackBar(
      title: 'Kết nối thành công',
      message: 'Đã kết nối thành công tới broker',
      duration: Duration(seconds: 3),
    ));

    isLoading.value = false;
    client.subscribe(BoxStorage.boxTopic, MqttQos.atLeastOnce);
    client.updates?.listen(
      (List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final String payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);
        DataModel dataMqtt = DataModel.fromJson(json.decode(payload));
        if (dataModel
            .map((element) => element.address)
            .contains(dataMqtt.address)) {
          int indexData = dataModel.indexWhere(
            (p0) => p0.address == dataMqtt.address,
          );
          dataModel[indexData].data = dataMqtt.data;
        } else {
          dataModel.add(dataMqtt);
        }
        nodeCtrl?.dataModel.value = dataMqtt;
        nodeCtrl?.nodeModel.update((val) {
          val?.yValue = FakeData.dataList;
          val?.dataValue.removeAt(0);
          val?.dataValue.add(
              double.parse(NodeComponent.getLastValue(dataMqtt, val.index)));
        });

        // Sắp xếp lại theo thứ tự address
        dataModel.sort((a, b) => a.address.compareTo(b.address));
      },
    );
  }

  List<String> get getDataString {
    return [
      DateFormat('HH:mm:ss')
          .format(DateTime.now().subtract(const Duration(seconds: 15))),
      DateFormat('HH:mm:ss')
          .format(DateTime.now().subtract(const Duration(seconds: 12))),
      DateFormat('HH:mm:ss')
          .format(DateTime.now().subtract(const Duration(seconds: 9))),
      DateFormat('HH:mm:ss')
          .format(DateTime.now().subtract(const Duration(seconds: 6))),
      DateFormat('HH:mm:ss')
          .format(DateTime.now().subtract(const Duration(seconds: 3))),
      DateFormat('HH:mm:ss').format(DateTime.now())
    ];
  }

  void onDisconnected() {
    logger.i('Disconnected');
    Get.offNamed(Routes.mqtt);
    Get.showSnackbar(
      const GetSnackBar(
        title: 'Lỗi kết nối',
        message: 'Xin hãy kiểm tra lại url hoặc mạng',
        duration: Duration(seconds: 3),
      ),
    );
  }

  NodeCtrl? get nodeCtrl {
    if (Get.isRegistered<NodeCtrl>()) {
      return Get.find<NodeCtrl>();
    }
    return null;
  }

  Future<void> publishMessage({required String payload}) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    client.publishMessage(
        "${BoxStorage.boxTopic}_send", MqttQos.atLeastOnce, builder.payload!);
  }

  Future<void> logOut() async {
    client.disconnect();
    BoxStorage.clear();
    Get.offAllNamed('/mqtt');
  }

  Future<void> showAlert() async {
    Get.dialog(NodeComponent.showDialog(this));
  }
}
