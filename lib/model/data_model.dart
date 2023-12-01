class DataModel {
  DataModel({
    this.temperature = 0,
    this.humidity = 0,
    this.uv = 0,
    this.fineDust = 0,
    this.cacbon = 0,
  });

  final double temperature;
  final double humidity;
  final double uv;
  final double fineDust;
  final double cacbon;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      temperature: json["temperature"] ?? 0,
      humidity: json["humidity"] ?? 0,
      uv: json["uv"] ?? 0,
      fineDust: json["fineDust"] ?? 0,
      cacbon: json["cacbon"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
        "uv": uv,
        "fineDust": fineDust,
        "cacbon": cacbon,
      };
}
