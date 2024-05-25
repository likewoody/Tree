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

  bool editmode = false;
  String editText = "수정하기";

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final postId = box.read('postId');

    return Scaffold(
      appBar: AppBar(
        title: Text('detail view'),
        actions: [
          GetBuilder<WriteVm>(builder: (controller) {
            return TextButton(
                onPressed: () {
                  controller.editingMode();
                },
                child: Text(controller.editingText));
          })
        ],
      ),
      body: GetBuilder<WriteVm>(builder: (controller) {
        controller.postId = postId;
        initPage(controller);
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
                      // Row 또는 Column이 자식으로 해당될 때 가능한 모든 여유 공간을 차지하게 해주는 위젯
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IntrinsicHeight(
                          //자식 위젯의 내재된 높이를 계산하고, 그 높이에 맞춰 자신의 높이를 조절
                          child: TextField(
                            controller: writeController,
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

  editingModeChange(WriteVm controller) {
    controller.editingText = editText;
    controller.editingmode = editmode;
    controller.editingMode();
  }

  initPage(WriteVm controller) {
    controller.detailView();
    travelPlaceController.text = controller.location;
    day1Controller.text = controller.day1;
    day2Controller.text = controller.day2;
    travelMateController.text = controller.mate;
    weatherController.text = controller.weather;

    //db에 저장되어 있는 travelList를 재정렬 하기 위해 formatTravelList함수 사용
    String formattedTravelList = formatTravelList(controller.travelList);
    writeController.text = formattedTravelList;
  }

  String formatTravelList(String travelList) {
    // '/../'을 기준으로 나눠 travelItems에 저장
    List<String> travelItems = travelList.split('/../');
    int dayCnt = 1;
    StringBuffer formattedList = StringBuffer();

    for (String item in travelItems) {
      //formattedList 작성
      formattedList.write('$dayCnt일차 \n$item\n\n');
      dayCnt++;
    }

    return formattedList.toString();
  }
}
