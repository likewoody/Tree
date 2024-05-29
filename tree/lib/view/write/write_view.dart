import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/vm/wrire/write_vm.dart';

class WriteView extends StatelessWidget {
  WriteView({super.key});

  final TextEditingController travelPlaceController = TextEditingController();
  final TextEditingController day1Controller = TextEditingController();
  final TextEditingController day2Controller = TextEditingController();
  final TextEditingController travelMateController = TextEditingController();
  final TextEditingController weatherController = TextEditingController();
  final TextEditingController writeController = TextEditingController();
  final WriteVm controller = WriteVm();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final postId = box.read('postId');
    controller.postId = postId;
    initPage(controller);

    return Scaffold(
      appBar: AppBar(
        title: Text('detail view'),
        leading: IconButton(
            onPressed: () async {
              var loc = travelPlaceController.text;
              var day1 = day1Controller.text;
              var day2 = day2Controller.text;
              var mate = travelMateController.text;
              var weather = weatherController.text;
              var list = writeController.text;
              controller.postId = postId;
              await controller.updateWrite(
                  loc, day1, day2, mate, weather, list);
              initPage(controller);
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          GetBuilder<WriteVm>(builder: (controller) {
            return TextButton(
                onPressed: () {
                  controller.editingMode();
                  print(controller.editingmode);
                },
                child: Text('수정하기'));
          })
        ],
      ),
      body: GetBuilder<WriteVm>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('여행지 : '),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: travelPlaceController,
                        readOnly: controller.editingmode,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: TextField(
                        controller: day1Controller,
                        readOnly: controller.editingmode,
                      ),
                    ),
                    Text("~"),
                    Container(
                      width: 100,
                      child: TextField(
                        controller: day2Controller,
                        readOnly: controller.editingmode,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('여행 메이트 : '),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: travelMateController,
                        readOnly: controller.editingmode,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('날씨 : '),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: weatherController,
                        readOnly: controller.editingmode,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IntrinsicHeight(
                          child: TextField(
                            controller: writeController,
                            readOnly: controller.editingmode,
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void initPage(WriteVm controller) async {
    controller.editingmode = true;
    print(controller.editingmode);

    await controller.detailView();

    travelPlaceController.text = controller.location;
    day1Controller.text = controller.day1;
    day2Controller.text = controller.day2;
    travelMateController.text = controller.mate;
    weatherController.text = controller.weather;

    String formattedTravelList = formatTravelList(controller.travelList);
    writeController.text = formattedTravelList;
  }

  String formatTravelList(String travelList) {
    List<String> travelItems = travelList.split('/../');
    int dayCnt = 1;
    StringBuffer formattedList = StringBuffer();

    for (int i = 0; i < travelItems.length; i++) {
      String item = travelItems[i];
      if (i == travelItems.length - 1) {
        // 마지막 아이템일 때
        formattedList.write('$dayCnt일차 \n$item');
      } else {
        formattedList.write('$dayCnt일차 \n$item\n\n');
      }
      dayCnt++;
    }

    return formattedList.toString();
  }
}
