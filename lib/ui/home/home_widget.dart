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

Widget _buildBody(HomeCtrl controller) {
  return Obx(
    () => Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          bottom: true,
          child: controller.nodeCtrl?.dataModel != []
              ? Row(
                  children: [
                    _buildNodeButton('Node 1'),
                    _buildNodeButton('Node 2'),
                    _buildNodeButton('Node 3'),
                  ],
                )
              : SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Center(
                    child: UtilWidget.buildText("Không có dữ liệu"),
                  ),
                ),
        ),
        if (controller.isLoading.value == true) ..._buildLoadingForm(),
      ],
    ),
  );
}

int getNode(String text) {
  if (text == 'Node 1') {
    return 1;
  } else if (text == 'Node 2') {
    return 2;
  } else {
    return 3;
  }
}

Widget _buildNodeButton(String text) {
  return Expanded(
    child: InkWell(
      onTap: () {
        Get.toNamed(
          Routes.node,
          arguments: getNode(text),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
  );
}
