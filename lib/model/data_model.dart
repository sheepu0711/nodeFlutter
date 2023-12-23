import 'package:get/get.dart';

class DataModel {
  DataModel({
    this.address = 0,
    this.data,
  });

  int address;
  Rx<Data>? data;
  RxBool isExpanded = false.obs;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      address: json["address"],
    )
      ..isExpanded.value = false
      ..data = json["data"] == null ? null : Data.fromJson(json["data"]).obs;
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "data": data?.toJson(),
      };
}

// "humi":"34.80","temp":"24.40","Flame":"0","Gas":"60"
class Data {
  Data({
    this.humi = "",
    this.temp = "",
    this.flame = "",
    this.gas = "",
    // this.uv = "",
  });

  String humi;
  String temp;
  String flame;
  String gas;
  // String uv;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      humi: json["humi"] ?? "",
      temp: json["temp"] ?? "",
      flame: json["flame"] ?? "",
      gas: json["gas"] ?? "",
      // uv: json["Uv"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Humi": humi,
        "Temp": temp,
        "Flame": flame,
        "Gas": gas,
        // "Uv": uv,
      };
}
