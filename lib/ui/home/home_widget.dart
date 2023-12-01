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

Widget _buildItem(int index, HomeCtrl controller) {
  return Obx(
    () => Container(
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
          _buildDataSensor(index, controller),
        ],
      ),
    ),
  );
}

Widget _buildBottomNavigationBar(HomeCtrl controller) {
  // return Obx(
  //   () => BottomNavigationBar(
  //     currentIndex: controller.currentIndex.value,
  //     onTap: (index) {
  //       controller.currentIndex.value = index;
  //     },
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: "Node 1",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.business),
  //         label: "Node 2",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.settings),
  //         label: "Node 3",
  //       ),
  //     ],
  //   ),
  // );
  return AnimatedNotchBottomBar(
    /// Provide NotchBottomBarController
    notchBottomBarController: controller.notchBottomBarController,
    color: Colors.white,
    showLabel: false,
    notchColor: Colors.black87,
    bottomBarWidth: 500,
    bottomBarItems: const [
      BottomBarItem(
        inActiveItem: Icon(
          Icons.home_filled,
          color: Colors.blueGrey,
        ),
        activeItem: Icon(
          Icons.home_filled,
          color: Colors.blueAccent,
        ),
        itemLabel: 'Page 1',
      ),
      BottomBarItem(
        inActiveItem: Icon(
          Icons.star,
          color: Colors.blueGrey,
        ),
        activeItem: Icon(
          Icons.star,
          color: Colors.blueAccent,
        ),
        itemLabel: 'Page 2',
      ),
      BottomBarItem(
        inActiveItem: Icon(
          Icons.search,
          color: Colors.blueGrey,
        ),
        activeItem: Icon(
          Icons.search,
          color: Colors.blueAccent,
        ),
        itemLabel: 'Page 3',
      ),
    ],
    onTap: (index) {
      controller.currentIndex.value = index;
    },
  );
}

Widget _buildBody(HomeCtrl controller) {
  return Obx(
    () => Stack(
      children: [
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: NodeComponent.iconData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return _buildItem(index, controller);
                  },
                ),
              ),
            ],
          ),
        ),
        if (controller.isLoading.value == true) ..._buildLoadingForm(),
      ],
    ),
  );
}

Widget _buildDataSensor(int index, HomeCtrl controller) {
  switch (index) {
    case 0:
      // return _buildDHTSensor(controller.dataModel.value.temperature);
      return UtilWidget.buildText(
        "Nhiệt độ: ${controller.dataModel.value.temperature}",
      );
    case 1:
      return UtilWidget.buildText(
        "Độ ẩm: ${controller.dataModel.value.humidity}",
      );
    case 2:
      return UtilWidget.buildText(
        "UV: ${controller.dataModel.value.uv}",
      );
    case 3:
      return UtilWidget.buildText(
        "Bụi mịn: ${controller.dataModel.value.fineDust}",
      );
    case 4:
      return UtilWidget.buildText(
        "Co2: ${controller.dataModel.value.cacbon}",
      );
    default:
      return UtilWidget.buildText("Lỗi đọc dữ liệu");
  }
}
