import 'package:get/get.dart';

class DataModel {
  DataModel({
    this.address = 0,
    this.data,
  });

  int address;
  Data? data;
  RxBool isExpanded = false.obs;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      address: json["address"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    )..isExpanded.value = false;
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.humi = "",
    this.temp = "",
    this.dust = "",
    this.co2 = "",
    this.uv = "",
  });

  String humi;
  String temp;
  String dust;
  String co2;
  String uv;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      humi: json["Humi"] ?? "",
      temp: json["Temp"] ?? "",
      dust: json["Dust"] ?? "",
      co2: json["Co2"] ?? "",
      uv: json["Uv"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Humi": humi,
        "Temp": temp,
        "Dust": dust,
        "Co2": co2,
        "Uv": uv,
      };
}
