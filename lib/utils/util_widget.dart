import 'package:flutter/material.dart';
import 'package:node_flutter/model/enum.dart';

class UtilWidget {
  static Widget buildText(String title) {
    return Text(
      title,
      maxLines: 2,
      textAlign: TextAlign.center,
    );
  }

  static String getTemp(Temperature temp) {
    switch (temp) {
      case Temperature.high:
        return "Nóng";
      case Temperature.medium:
        return "Bình thường";
      case Temperature.low:
        return "Lạnh";
      default:
        return "Lỗi";
    }
  }

  static String getHumi(Humidity humi) {
    switch (humi) {
      case Humidity.high:
        return "Cao";
      case Humidity.medium:
        return "Trung bình";
      case Humidity.low:
        return "Thấp";
      default:
        return "Lỗi";
    }
  }

  static String getDust(Dust dust) {
    switch (dust) {
      case Dust.green:
        return "Tốt";
      case Dust.yellow:
        return "Cảnh báo";
      case Dust.red:
        return "Xấu";
      default:
        return "Lỗi";
    }
  }

  static String getCo2(Co2 co2) {
    switch (co2) {
      case Co2.green:
        return "Tốt";
      case Co2.red:
        return "Cảnh báo";
      case Co2.danger:
        return "Nguy hiểm";
      default:
        return "Lỗi";
    }
  }

  static String getUv(Uv uv) {
    switch (uv) {
      case Uv.safe:
        return "Tốt";
      case Uv.danger:
        return "Xấu";
      default:
        return "Lỗi";
    }
  }

  static Color getColorTemp(Temperature temp) {
    switch (temp) {
      case Temperature.high:
        return Colors.red;
      case Temperature.medium:
        return Colors.green;
      case Temperature.low:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  static Color getColorHumi(Humidity humi) {
    switch (humi) {
      case Humidity.high:
        return Colors.red;
      case Humidity.medium:
        return Colors.green;
      case Humidity.low:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  static Color getColorDust(Dust dust) {
    switch (dust) {
      case Dust.green:
        return Colors.green;
      case Dust.yellow:
        return Colors.yellow;
      case Dust.red:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  static Color getColorCo2(Co2 co2) {
    switch (co2) {
      case Co2.green:
        return Colors.green;
      case Co2.red:
        return Colors.yellow;
      case Co2.danger:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  static Color getColorUv(Uv uv) {
    switch (uv) {
      case Uv.safe:
        return Colors.green;
      case Uv.danger:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
