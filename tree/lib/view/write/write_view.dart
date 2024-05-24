import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final userid = box.read('postId');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('detail view'),
      ),
      body: Center(
        child: GetBuilder<WriteVm>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                    Container(
                      width: 280,
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.editingMode();
                                },
                                child: Text(controller.editingText),
                              ),
                            ],
                          ),
                          Container(
                            width: 200,
                            child: TextField(
                              controller: writeController,
                              maxLines: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  editingModeChange(WriteVm controller) {
    controller.editingText = editText;
    controller.editingmode = editmode;
    controller.editingMode();
  }
}
