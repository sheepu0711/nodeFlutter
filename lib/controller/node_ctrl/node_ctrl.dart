import 'package:get/get.dart';
import 'package:node_flutter/model/data_model.dart';
import 'package:node_flutter/utils/utils_src.dart';

class NodeCtrl extends GetxController {
  RxList<DataModel> dataModel = <DataModel>[].obs;

  int node = 0;
  @override
  void onInit() {
    super.onInit();
    node = Get.arguments;
    logger.i("node $node");
  }
}
