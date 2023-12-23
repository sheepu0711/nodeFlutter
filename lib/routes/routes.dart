import 'package:node_flutter/controller/controller_src.dart';
import 'package:node_flutter/controller/node_ctrl/node_ctrl.dart';
import 'package:node_flutter/ui/node/node_page.dart';
import 'package:node_flutter/ui/ui_src.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const home = '/home';
  static const splash = '/splash';
  static const mqtt = '/mqtt';
  static const node = '/node';
}

abstract class AppPages {
  static String initial = Routes.splash;
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
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
    GetPage(
      name: Routes.node,
      page: () => const NodePage(),
      binding: BindingsBuilder.put(
        () => NodeCtrl(),
      ),
    ),
  ];
}
