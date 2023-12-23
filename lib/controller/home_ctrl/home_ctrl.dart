import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:node_flutter/components/node_components.dart';
import 'package:node_flutter/model/model_src.dart';
import 'package:node_flutter/routes/routes.dart';
import 'package:node_flutter/utils/utils_src.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class HomeCtrl extends GetxController {
  // Khai báo client kết nối tới broker
  final client = MqttServerClient(BoxStorage.boxUrl, '');

  // Khai báo biến để kiểm tra trạng thái kết nối đến MQTT hay chưa
  RxBool isLoading = false.obs;

  // Khai báo biến để lưu trữ dữ liệu nhận được từ MQTT
  RxList<DataModel> dataModel = <DataModel>[].obs;

  // Hàm được gọi khi màn hình được khởi tạo
  @override
  void onInit() async {
    await connect();
    super.onInit();
  }

  // Kết nối đến MQTT từ các dữ liệu được lưu từ màn MQTT
  Future<void> connect() async {
    // Hiển thị loading
    isLoading.value = true;

    // Lấy port
    client.port = int.parse(BoxStorage.boxPort);
    // Thời gian giữ kết nối khi không có bản tin mới
    client.keepAlivePeriod = 20;

    // Thời gian chờ kết nối
    client.connectTimeoutPeriod = 2000;

    // Khai báo các hàm callback khi kết nối thành công, thất bại, ...
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;

    // Khai báo thông tin kết nối
    final connMess = MqttConnectMessage()
        .withClientIdentifier(DateTime.now().millisecondsSinceEpoch.toString())
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;

    // Thực hiện kết nối
    // Đặt hàm trong try catch để bắt lỗi khi kết nối
    // tránh ứng dụng bị crash
    try {
      // Tiến hành kết nối với username, password
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
    // Hiển thị thanh thông báo ngắn ở dưới màn hình
    Get.showSnackbar(const GetSnackBar(
      title: 'Kết nối thành công',
      message: 'Đã kết nối thành công tới broker',
      duration: Duration(seconds: 3),
    ));
    // Ẩn loading
    isLoading.value = false;
    // Đăng ký lắng nghe các bản tin từ topic
    client.subscribe(BoxStorage.boxTopic, MqttQos.atLeastOnce);
    // Thực hiện lắng nghe khi có dữ liệu mới từ MQTT truyền về
    client.updates?.listen(
      (List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final String payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);
        // Parse dữ liệu từ String qua model DataModel
        DataModel dataMqtt = DataModel.fromJson(json.decode(payload));
        // Kiểm tra xem dữ liệu đã có trong list chưa
        // Nếu có rồi thì cập nhật lại data của dữ liệu
        // Nếu chưa có thì thêm vào list
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
        // Sắp xếp lại theo thứ tự address
        dataModel.sort((a, b) => a.address.compareTo(b.address));
      },
    );
  }

  void onDisconnected() {
    // Huỷ bỏ trang hiện tại và đến màn MQTT khi lỗi kết nối
    Get.offNamed(Routes.mqtt);
    // Hiển thị thanh thông báo ngắn ở dưới màn hình
    Get.showSnackbar(
      const GetSnackBar(
        title: 'Lỗi kết nối',
        message: 'Xin hãy kiểm tra lại url hoặc mạng',
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Future<void> publishMessage({required String payload}) async {
  //   final builder = MqttClientPayloadBuilder();
  //   builder.addString(payload);
  //   client.publishMessage(
  //       "${BoxStorage.boxTopic}_send", MqttQos.atLeastOnce, builder.payload!);
  // }

  // Đăng xuất (chuyển về màn hình MQTT)
  Future<void> logOut() async {
    client.disconnect();
    BoxStorage.clear();
    Get.offAllNamed('/mqtt');
  }

  // Hiển thị 1 popup xác nhận đăng xuất hay không
  Future<void> showAlert() async {
    Get.dialog(NodeComponent.showDialog(this));
  }
}
