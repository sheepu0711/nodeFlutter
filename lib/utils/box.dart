import 'package:nodeflutter/utils/utils_src.dart';
import 'package:get_storage/get_storage.dart';

class BoxStorage {
  static final box = GetStorage();

  static bool get haveMqtt => box.read(BoxValue.haveMqtt) ?? false;

  static String get boxUrl => box.read(BoxValue.boxUrl) ?? '';

  static String get boxPort => box.read(BoxValue.boxPort) ?? '';

  static String get boxUsername => box.read(BoxValue.boxUsername) ?? '';

  static String get boxPassword => box.read(BoxValue.boxPassword) ?? '';

  static String get boxTopic => box.read(BoxValue.boxTopic) ?? '';

  static final BoxStorage _singleton = BoxStorage._internal();

  factory BoxStorage() {
    return _singleton;
  }

  BoxStorage._internal();

  static void setHaveMqtt(bool value) {
    box.write(BoxValue.haveMqtt, value);
  }

  static void setBoxUrl(String value) {
    box.write(BoxValue.boxUrl, value);
  }

  static void setBoxPort(String value) {
    box.write(BoxValue.boxPort, value);
  }

  static void setBoxUsername(String value) {
    box.write(BoxValue.boxUsername, value);
  }

  static void setBoxPassword(String value) {
    box.write(BoxValue.boxPassword, value);
  }

  static void setBoxTopic(String value) {
    box.write(BoxValue.boxTopic, value);
  }

  static void clear() {
    box.erase();
  }
}
