part of 'home_page.dart';

Widget _buildBody(HomeCtrl controller) {
  return Obx(
    () => Stack(
      children: [
        // Kiểm tra nếu có dữ liệu hay không
        controller.dataModel.isNotEmpty
            ? SafeArea(
                bottom: true,
                child: Obx(
                  () => SingleChildScrollView(
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        controller.dataModel[index].isExpanded.toggle();
                      },
                      // Map từng dữ liệu (từng node) để hiển thị
                      children: controller.dataModel
                          .toList()
                          .asMap()
                          .entries
                          .map(
                            (e) => ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(e.value.address.toString()),
                                );
                              },
                              // Chi tiết nhiệt độ, độ ẩm, ... của từng node
                              body: _buildNode(e.value.address, controller),
                              isExpanded: e.value.isExpanded.value,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              )
            : const Center(
                child: Text("Không có dữ liệu"),
              ),
        if (controller.isLoading.value == true) ..._buildLoadingForm(),
      ],
    ),
  );
}

List<Widget> _buildLoadingForm() {
  return [
    const Opacity(
      opacity: 0.8,
      child: ModalBarrier(dismissible: false, color: Colors.black),
    ),
    const Center(
      child: CircularProgressIndicator(),
    ),
  ];
}

// Chi tiết nhiệt độ, độ ẩm, ... của từng node
Widget _buildNode(int indexList, HomeCtrl controller) {
  // Dùng GridView để hiển thị theo dạng 2, 3 ô 1 hàng
  return GridView.builder(
    shrinkWrap: true,
    itemCount: NodeComponent.iconData.length,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemBuilder: (context, index) => Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Column(
        // alignment: Alignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              NodeComponent.iconData[index] ?? "",
              // ignore: deprecated_member_use
              color: Colors.blue.withOpacity(0.4),
              height: 100,
            ),
          ),
          _buildDataSensor(index, indexList, controller),
          _buildMaxRange(index, indexList, controller),
        ],
      ),
    ),
  );
}

// Chi tiết các dữ liệu
Widget _buildDataSensor(int indexData, int indexList, HomeCtrl controller) {
  // Tìm kiếm vị trí của dữ liệu trong list
  int index = controller.dataModel.indexWhere(
    (p0) => p0.address == indexList,
  );
  // Kiểm tra xem dữ liệu đấy là gì rồi hiển thị text + dữ liệu
  switch (indexData) {
    case 0:
      return UtilWidget.buildText(
        "Nhiệt độ: ${controller.dataModel[index].data?.value.temp}",
      );
    case 1:
      return UtilWidget.buildText(
        "Độ ẩm: ${controller.dataModel[index].data?.value.humi}",
      );
    case 2:
      return UtilWidget.buildText(
        "Lửa: ${controller.dataModel[index].data?.value.flame}",
      );
    case 3:
      return UtilWidget.buildText(
        "Gas: ${controller.dataModel[index].data?.value.gas}",
      );
    default:
      return UtilWidget.buildText("Lỗi đọc dữ liệu");
  }
}

Widget _buildMaxRange(int indexData, int indexList, HomeCtrl controller) {
  int index = controller.dataModel.indexWhere(
    (p0) => p0.address == indexList,
  );
  switch (indexData) {
    case 0:
      // return _buildDHTSensor(controller.dataModel.value.temperature);
      return Text(
        UtilWidget.getTemp(
          RageNode.temperature(controller.dataModel[index].data!.value.temp),
        ),
        style: TextStyle(
          color: UtilWidget.getColorTemp(
            RageNode.temperature(controller.dataModel[index].data!.value.temp),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 1:
      return Text(
        UtilWidget.getHumi(
          RageNode.humidity(controller.dataModel[index].data!.value.humi),
        ),
        style: TextStyle(
          color: UtilWidget.getColorHumi(
            RageNode.humidity(controller.dataModel[index].data!.value.humi),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 2:
      return Text(
        UtilWidget.getFlame(
          RageNode.flame(controller.dataModel[index].data!.value.flame),
        ),
        style: TextStyle(
          color: UtilWidget.getColorFlame(
            RageNode.flame(controller.dataModel[index].data!.value.flame),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );
    case 3:
      return Text(
        UtilWidget.getGas(
          RageNode.gas(controller.dataModel[index].data!.value.gas),
        ),
        style: TextStyle(
          color: UtilWidget.getColorGas(
            RageNode.gas(controller.dataModel[index].data!.value.gas),
          ),
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      );

    default:
      return UtilWidget.buildText("Lỗi đọc dữ liệu");
  }
}
