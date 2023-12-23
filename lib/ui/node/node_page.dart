import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodeflutter/components/node_components.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodeflutter/ui/node/linechart.dart';
import 'package:nodeflutter/utils/rage.dart';

import '../../utils/util_widget.dart';
import '../../controller/node_ctrl/node_ctrl.dart';

class NodePage extends GetView<NodeCtrl> {
  const NodePage({super.key});

  @override
  NodeCtrl get controller => Get.find<NodeCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Node"),
        centerTitle: true,
        backgroundColor: Colors.blue.withOpacity(0.4),
      ),
      body: Obx(
        () => Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: controller.dataModel.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildGraph(controller),
                      _buildNode(controller.node, controller),
                    ],
                  ),
                )
              : Center(
                  child: UtilWidget.buildText("Không có dữ liệu"),
                ),
        ),
      ),
      extendBody: true,
    );
  }
}

Widget _buildGraph(NodeCtrl controller) {
  return const LineChartSample1();
}

Widget _buildNode(int indexList, NodeCtrl controller) {
  return GridView.builder(
    shrinkWrap: true,
    itemCount: NodeComponent.iconData.length,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                NodeComponent.iconData[index] ?? "",
                // ignore: deprecated_member_use
                color: Colors.blue.withOpacity(0.4),
                height: 50,
              ),
            ),
            _buildDataSensor(index, indexList, controller),
            _buildMaxRange(index, indexList, controller),
          ],
        ),
      );
    },
  );
}

Widget _buildDataSensor(int indexData, int indexList, NodeCtrl controller) {
  switch (indexData) {
    case 0:
      // return _buildDHTSensor(controller.dataModel.value.temperature);
      return UtilWidget.buildText(
        "Nhiệt độ: ${controller.dataModel[indexList].data!.temp}",
      );
    case 1:
      return UtilWidget.buildText(
        "Độ ẩm: ${controller.dataModel[indexList].data!.humi}",
      );
    case 2:
      return UtilWidget.buildText(
        "UV: ${controller.dataModel[indexList].data!.uv}",
      );
    case 3:
      return UtilWidget.buildText(
        "Bụi mịn: ${controller.dataModel[indexList].data!.dust}",
      );
    case 4:
      return UtilWidget.buildText(
        "Co2: ${controller.dataModel[indexList].data!.co2}",
      );
    default:
      return UtilWidget.buildText("Lỗi đọc dữ liệu");
  }
}

Widget _buildMaxRange(int indexData, int indexList, NodeCtrl controller) {
  switch (indexData) {
    case 0:
      // return _buildDHTSensor(controller.dataModel.value.temperature);
      return Text(
        UtilWidget.getTemp(
          RageNode.temperature(controller.dataModel[indexList].data!.temp),
        ),
        style: TextStyle(
          color: UtilWidget.getColorTemp(
            RageNode.temperature(controller.dataModel[indexList].data!.temp),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 1:
      return Text(
        UtilWidget.getHumi(
          RageNode.humidity(controller.dataModel[indexList].data!.humi),
        ),
        style: TextStyle(
          color: UtilWidget.getColorHumi(
            RageNode.humidity(controller.dataModel[indexList].data!.humi),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 2:
      return Text(
        UtilWidget.getUv(
          RageNode.uv(controller.dataModel[indexList].data!.uv),
        ),
        style: TextStyle(
          color: UtilWidget.getColorUv(
            RageNode.uv(controller.dataModel[indexList].data!.uv),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 3:
      return Text(
        UtilWidget.getDust(
          RageNode.dust(controller.dataModel[indexList].data!.dust),
        ),
        style: TextStyle(
          color: UtilWidget.getColorDust(
            RageNode.dust(controller.dataModel[indexList].data!.dust),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 4:
      return Text(
        UtilWidget.getCo2(
          RageNode.co2(controller.dataModel[indexList].data!.co2),
        ),
        style: TextStyle(
          color: UtilWidget.getColorCo2(
            RageNode.co2(controller.dataModel[indexList].data!.co2),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    default:
      return UtilWidget.buildText("Lỗi đọc dữ liệu");
  }
}
