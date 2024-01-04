import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodeflutter/components/node_components.dart';
import 'package:nodeflutter/utils/app_colors.dart';
import 'package:nodeflutter/utils/fake_data.dart';
import 'package:nodeflutter/utils/rage.dart';

import '../../controller/node_ctrl/node_ctrl.dart';
import '../../utils/util_widget.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                _buildChartWidget(controller),
                _buildNode(controller.dataModel.value.address, controller),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
    );
  }
}

Widget _buildChartWidget(NodeCtrl controller) {
  return AspectRatio(
    aspectRatio: 1.23,
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Text(
            controller.nodeModel.value.dataLabel,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 37,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 6),
              child: _buildChart(controller),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
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
      return InkWell(
        onTap: () {
          controller.nodeModel.update((val) {
            val!.yValue = FakeData.dataList;
          });
          controller.dataIndex.value = index;
          controller.changeData(index);
        },
        child: Container(
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
        "Nhiệt độ: ${controller.dataModel.value.data!.temp}",
      );
    case 1:
      return UtilWidget.buildText(
        "Độ ẩm: ${controller.dataModel.value.data!.humi}",
      );
    case 2:
      return UtilWidget.buildText(
        "UV: ${controller.dataModel.value.data!.uv}",
      );
    case 3:
      return UtilWidget.buildText(
        "Bụi mịn: ${controller.dataModel.value.data!.dust}",
      );
    case 4:
      return UtilWidget.buildText(
        "Co2: ${controller.dataModel.value.data!.co2}",
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
          RageNode.temperature(controller.dataModel.value.data!.temp),
        ),
        style: TextStyle(
          color: UtilWidget.getColorTemp(
            RageNode.temperature(controller.dataModel.value.data!.temp),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 1:
      return Text(
        UtilWidget.getHumi(
          RageNode.humidity(controller.dataModel.value.data!.humi),
        ),
        style: TextStyle(
          color: UtilWidget.getColorHumi(
            RageNode.humidity(controller.dataModel.value.data!.humi),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 2:
      return Text(
        UtilWidget.getUv(
          RageNode.uv(controller.dataModel.value.data!.uv),
        ),
        style: TextStyle(
          color: UtilWidget.getColorUv(
            RageNode.uv(controller.dataModel.value.data!.uv),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 3:
      return Text(
        UtilWidget.getDust(
          RageNode.dust(controller.dataModel.value.data!.dust),
        ),
        style: TextStyle(
          color: UtilWidget.getColorDust(
            RageNode.dust(controller.dataModel.value.data!.dust),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 4:
      return Text(
        UtilWidget.getCo2(
          RageNode.co2(controller.dataModel.value.data!.co2),
        ),
        style: TextStyle(
          color: UtilWidget.getColorCo2(
            RageNode.co2(controller.dataModel.value.data!.co2),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    default:
      return UtilWidget.buildText("Lỗi đọc dữ liệu");
  }
}

Widget _buildChart(NodeCtrl controller) {
  return LineChart(
    LineChartData(
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1(controller),
      borderData: borderData,
      lineBarsData: lineBarsData1(controller),
      minX: 0,
      maxX: 14,
      maxY: 5,
      minY: 0,
    ),
    duration: const Duration(milliseconds: 250),
  );
}

LineTouchData get lineTouchData1 => LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
    );

FlTitlesData titlesData1(NodeCtrl controller) => FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles(controller),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTitles(controller),
      ),
    );

List<LineChartBarData> lineBarsData1(NodeCtrl controller) => [
      lineChartBarData1_1(controller),
    ];

Widget leftTitleWidgets(double value, TitleMeta meta, NodeCtrl controller) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = controller.nodeModel.value.dataRange[0].toString();
      break;
    case 2:
      text = controller.nodeModel.value.dataRange[1].toString();
      break;
    case 3:
      text = controller.nodeModel.value.dataRange[2].toString();
      break;
    case 4:
      text = controller.nodeModel.value.dataRange[3].toString();
      break;
    case 5:
      text = controller.nodeModel.value.dataRange[4].toString();
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.center);
}

SideTitles leftTitles(NodeCtrl controller) => SideTitles(
      getTitlesWidget: (value, meta) {
        return leftTitleWidgets(value, meta, controller);
      },
      showTitles: true,
      interval: 1,
      reservedSize: 40,
    );

Widget bottomTitleWidgets(double value, TitleMeta meta, NodeCtrl controller) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  Widget text;

  switch (value.toInt()) {
    case 2:
      text =
          Text(controller.nodeModel.value.yValue[1].toString(), style: style);
      break;
    case 6:
      text =
          Text(controller.nodeModel.value.yValue[3].toString(), style: style);
      break;
    case 10:
      text =
          Text(controller.nodeModel.value.yValue[5].toString(), style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  controller.update();
  // return SideTitleWidget(
  //   space: 2,
  //   axisSide: meta.axisSide,
  //   child: SizedBox(height: 100, width: 70, child: text),
  // );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: text,
  );
}

SideTitles bottomTitles(NodeCtrl controller) => SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: (value, meta) =>
          bottomTitleWidgets(value, meta, controller),
    );

FlGridData get gridData => const FlGridData(show: false);

FlBorderData get borderData => FlBorderData(
      show: true,
      border: Border(
        bottom: BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
        left: const BorderSide(color: Colors.transparent),
        right: const BorderSide(color: Colors.transparent),
        top: const BorderSide(color: Colors.transparent),
      ),
    );

LineChartBarData lineChartBarData1_1(NodeCtrl controller) {
  double range = (controller.nodeModel.value.dataRange.last - 0) / 4;
  List<FlSpot> spots = [];
  for (int i = 0; i < controller.nodeModel.value.dataValue.length; i++) {
    spots.add(
      FlSpot(
        (i * 2),
        (controller.nodeModel.value.dataValue[i] / range) + 1,
      ),
    );
  }
  controller.update();
  return LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorGreen,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: spots,
  );
}
