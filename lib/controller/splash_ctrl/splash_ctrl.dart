import 'package:node_flutter/routes/routes.dart';
import 'package:node_flutter/utils/utils_src.dart';
import 'package:get/get.dart';

class SplashCtrl extends GetxController {

  // Hàm được gọi khi màn hình được khởi tạo
  @override
  void onInit() async {
    await checkMqtt();
    super.onInit();
  }

  Future<void> checkMqtt() async {
    // Đợi 2 giây để kiểm tra xem đã có thông tin về Mqtt lưu trong bộ nhớ chưa
    await Future.delayed(const Duration(seconds: 2));
    // Nếu đã có thông tin về Mqtt thì chuyển sang màn hình Home
    // Nếu chưa có thì chuyển sang màn hình Mqtt 
    if (BoxStorage.haveMqtt) {
      Get.offNamed(Routes.home);
    } else {
      Get.offNamed(Routes.mqtt);
    }
  }
}
