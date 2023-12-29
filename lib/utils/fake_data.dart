import 'package:intl/intl.dart';

class FakeData {
  static List listData = [temperature, humidity, uv, dust, co2];

  static List<String> get dataList => [
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

  static List<double> temperature = [
    20,
    24,
    19,
    30,
    21,
    8,
    19,
    10,
    15,
    20,
  ];

  static List<double> humidity = [
    22,
    35,
    10,
    21,
    20,
    37,
    19,
    10,
    15,
    20,
  ];

  static List<double> uv = [
    1,
    2,
    3,
    1,
    4,
    2,
    1,
    2,
    1,
    3,
  ];

  static List<double> dust = [
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
  ];

  static List<double> co2 = [
    3953,
    2566,
    4783,
    675,
    3184,
  ];
}
