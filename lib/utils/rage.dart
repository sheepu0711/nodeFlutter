import 'package:nodeflutter/model/enum.dart';

class RageNode {
  static List<double> humidityRange = [20, 40, 60, 80, 100];
  static List<double> temperatureRange = [12, 22, 28, 35, 40];
  static List<double> dustRange = [0, 13.875, 27.75, 41.625, 55.5];
  static List<double> co2Range = [0, 2.5, 5, 7.5, 10];
  static List<double> uvRange = [0, 2.5, 5, 7.5, 10];

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

    if (dust >= 0 && dust < 12) {
      return Dust.good;
    } else if (dust >= 12 && dust < 35.4) {
      return Dust.normal;
    } else if (dust >= 35.5 && dust < 55.4) {
      return Dust.bad;
    } else {
      return Dust.danger;
    }
  }

  static Co2 co2(String value) {
    double co2 = double.parse(value);
    if (co2 >= 0.1 && co2 < 1) {
      return Co2.green;
    } else if (co2 >= 1 && co2 < 10) {
      return Co2.red;
    } else {
      return Co2.danger;
    }
  }

  static Uv uv(String value) {
    double uv = double.parse(value);
    if (uv >= 0 && uv < 2) {
      return Uv.good;
    } else if (uv >= 2 && uv < 5) {
      return Uv.medium;
    } else if (uv >= 5 && uv < 7) {
      return Uv.high;
    } else if (uv >= 7 && uv < 10) {
      return Uv.veryHigh;
    } else {
      return Uv.danger;
    }
  }
}
