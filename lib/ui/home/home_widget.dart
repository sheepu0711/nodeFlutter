part of 'home_page.dart';

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

Widget _buildNode(int indexList, HomeCtrl controller) {
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
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
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
          ],
        ),
      );
    },
  );
}

Widget _buildBody(HomeCtrl controller) {
  return Obx(
    () => Stack(
      children: [
        controller.dataModel.isNotEmpty
            ? SafeArea(
                bottom: true,
                child: Obx(
                  () => SingleChildScrollView(
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        controller.dataModel[index].isExpanded.toggle();
                        logger.i(controller.dataModel[index].isExpanded.value);

                        // print(controller.dataModel);
                      },
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

Widget _buildDataSensor(int indexData, int indexList, HomeCtrl controller) {
  int index = controller.dataModel.indexWhere(
    (p0) => p0.address == indexList,
  );
  switch (indexData) {
    case 0:
      // return _buildDHTSensor(controller.dataModel.value.temperature);
      return UtilWidget.buildText(
        "Nhiệt độ: ${controller.dataModel[index].data?.value.temp}",
      );
    case 1:
      return UtilWidget.buildText(
        "Độ ẩm: ${controller.dataModel[index].data?.value.humi}",
      );
    // case 2:
    //   return UtilWidget.buildText(
    //     "UV: ${controller.dataModel[indexList].data!.uv}",
    //   );
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
