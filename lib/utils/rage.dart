import 'package:nodeflutter/model/enum.dart';

class RageNode {
  static Humidity humidity(String value) {
    double humi = double.parse(value);
    if (humi >= 80) {
      return Humidity.high;
    } else if (humi <= 40) {
      return Humidity.low;
    } else {
      return Humidity.medium;
    }
  }

  static Temperature temperature(String value) {
    double temp = double.parse(value);
    if (temp >= 35) {
      return Temperature.high;
    } else if (temp <= 22) {
      return Temperature.low;
    } else {
      return Temperature.medium;
    }
  }

  static Dust dust(String value) {
    double dust = double.parse(value);
    if (dust >= 13 && dust <= 35) {
      return Dust.green;
    } else if (dust >= 36 && dust <= 55) {
      return Dust.yellow;
    } else {
      return Dust.red;
    }
  }

  static Co2 co2(String value) {
    double co2 = double.parse(value);
    if (co2 <= 1000) {
      return Co2.green;
    } else if (co2 > 1000 && co2 <= 5000) {
      return Co2.red;
    } else {
      return Co2.danger;
    }
  }

  static Uv uv(String value) {
    double uv = double.parse(value);
    if (uv <= 3) {
      return Uv.safe;
    } else {
      return Uv.danger;
    }
  }
}
