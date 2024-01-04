import 'package:get/get.dart';
import 'package:nodeflutter/model/data_model.dart';
import 'package:nodeflutter/model/node_model.dart';
import 'package:nodeflutter/utils/fake_data.dart';
import 'package:nodeflutter/utils/rage.dart';

class NodeCtrl extends GetxController {
  Rx<DataModel> dataModel = DataModel().obs;

  RxInt dataIndex = 0.obs;

  // RxList<int> dataValueLocal = FakeData.temperature.obs;

  Rx<NodeModel> nodeModel = NodeModel(
    dataLabel: "Nhiệt độ",
    yValue: FakeData.dataList,
    dataRange: RageNode.temperatureRange,
    index: 0,
    dataValue: FakeData.temperature,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    dataModel.value = Get.arguments;
    // dataValueLocal.value = nodeModel.value.dataValue;
  }

  void changeData(int index) {
    nodeModel.value.dataLabel = getLabel(index);
    nodeModel.value.dataRange = getRange(index);
    nodeModel.value.dataValue = getDataValue(index);
    nodeModel.value.index = index;
    // dataValueLocal.value = nodeModel.value.dataValue;
  }

  List<double> getDataValue(int index) {
    switch (index) {
      case 0:
        return FakeData.temperature;
      case 1:
        return FakeData.humidity;
      case 2:
        return FakeData.uv;
      case 3:
        return FakeData.dust;
      case 4:
        return FakeData.co2;
      default:
        return FakeData.temperature;
    }
  }

  String getLabel(int index) {
    switch (index) {
      case 0:
        return "Nhiệt độ";
      case 1:
        return "Độ ẩm";
      case 2:
        return "UV";
      case 3:
        return "Bụi mịn";
      case 4:
        return "CO2";
      default:
        return "Temperature";
    }
  }

  List<double> getRange(int index) {
    switch (index) {
      case 0:
        return RageNode.temperatureRange;
      case 1:
        return RageNode.humidityRange;
      case 2:
        return RageNode.uvRange;
      case 3:
        return RageNode.dustRange;
      case 4:
        return RageNode.co2Range;
      default:
        return RageNode.temperatureRange;
    }
  }
}
