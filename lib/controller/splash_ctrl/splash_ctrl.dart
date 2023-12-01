
import 'package:doanalong/routes/routes.dart';
import 'package:doanalong/utils/utils_src.dart';
import 'package:get/get.dart';

class SplashCtrl extends GetxController {
  @override
  void onInit() async {
    await checkMqtt();
    super.onInit();
  }

  Future<void> checkMqtt() async {
    await Future.delayed(const Duration(seconds: 2));
    if (BoxStorage.haveMqtt) {
      Get.offNamed(Routes.home);
    } else {
      Get.offNamed(Routes.mqtt);
    }
  }
}
