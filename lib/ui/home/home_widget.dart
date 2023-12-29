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
          child: controller.dataModel.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.dataModel.length,
                  itemBuilder: (context, index) =>
                      _buildNodeButton(controller, index),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
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

Widget _buildNodeButton(HomeCtrl controller, int index) {
  return InkWell(
    onTap: () {
      Get.toNamed(
        Routes.node,
        arguments: controller.dataModel[index],
      );
      // print(controller.dataModel[index]);
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
          "Node ${controller.dataModel[index].address}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
