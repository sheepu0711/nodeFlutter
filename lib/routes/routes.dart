import 'package:node_flutter/controller/controller_src.dart';
import 'package:node_flutter/ui/ui_src.dart';
import 'package:get/get.dart';
// Các màn hình của ứng dụng
abstract class Routes {
  static const home = '/home';
  static const splash = '/splash';
  static const mqtt = '/mqtt';
}
// Khai báo màn hình và controller tương ứng
abstract class AppPages {
  // Màn hình bắt đầu khi vào ứng dụng
  static String initial = Routes.splash;
  static final routes = [
    GetPage(
      // Tên màn hình: Home
      name: Routes.home,
      // UI hiển thị của màn hình
      page: () => const HomePage(),
      // Controller xử lý luồng của màn hình Home
      binding: BindingsBuilder.put(
        () => HomeCtrl(),
      ),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder.put(
        () => SplashCtrl(),
      ),
    ),
    GetPage(
      name: Routes.mqtt,
      page: () => const MqttPage(),
      binding: BindingsBuilder.put(
        () => MqttCtrl(),
      ),
    ),
  ];
}
