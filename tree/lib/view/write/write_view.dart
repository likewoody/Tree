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
        actions: [
          GetBuilder<WriteVm>(builder: (controller) {
            return TextButton(
              onPressed: () {
                editingModeChange(controller);
              },
              child: Text(controller.editingText),
            );
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
                      ),
                    ),
                    Text("~"),
                    Container(
                      width: 100,
                      child: TextField(
                        controller: day2Controller,
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
                            readOnly: !controller.editingmode,
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
              ElevatedButton(
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
                  },
                  child: Text('수정제발'))
            ],
          ),
        );
      }),
    );
  }

  void editingModeChange(WriteVm controller) {
    controller.editingMode();
  }

  void initPage(WriteVm controller) async {
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

    for (String item in travelItems) {
      formattedList.write('$dayCnt일차 \n$item\n\n');
      dayCnt++;
    }

    return formattedList.toString();
  }
}
