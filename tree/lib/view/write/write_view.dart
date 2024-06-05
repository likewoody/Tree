import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:td_app/view/write/editWrite.dart';
import 'package:td_app/vm/wrire/write_vm.dart';

class WriteView extends StatelessWidget {
  WriteView({super.key});

  final TextEditingController travelPlaceController = TextEditingController();
  final TextEditingController day1Controller = TextEditingController();
  final TextEditingController day2Controller = TextEditingController();
  final TextEditingController travelMateController = TextEditingController();
  final TextEditingController weatherController = TextEditingController();
  final TextEditingController writeController = TextEditingController();
  late String travelPlace = "";
  late String day1 = "";
  late String day2 = "";
  late String travelMate = "";
  late String weather = "";
  late List<String> travelItems = [];
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final postId = box.read('postId');

    return GetBuilder<WriteVm>(builder: (controller) {
      controller.detailView();
      controller.postId = postId;
      initPage(controller);

      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Column(
              children: [
                Image.asset(
                  "images/tree.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                )
              ],
            ),
            leading: IconButton(
                onPressed: () {
                  controller.dayCnt = 0;
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios)),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                        backgroundColor: Colors.white,
                        SizedBox(
                          width: 500,
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: '삭제하시겠습니까?',
                                          middleText: '삭제한 게시물은 복구할 수 없습니다.',
                                          actions: [
                                            Center(
                                              child: Row(
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        controller.deletePost();
                                                        Get.back();
                                                        Get.back();
                                                        Get.back();
                                                      },
                                                      child: Text('네')),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Get.back();
                                                        Get.back();
                                                      },
                                                      child: Text('아니요')),
                                                ],
                                              ),
                                            )
                                          ]);
                                    },
                                    child: Text(
                                      '삭제',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(EditWrite());
                                    },
                                    child: Text(
                                      '수정',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                  icon: Icon(Icons.menu))
            ],
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '여행지 : ${travelPlace}',
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text('날씨 : ${weather}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('여행 날짜 : '),
                      Text(day1),
                      Text('  ~  '),
                      Text(day2),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('여행 메이트 : ${travelMate}'),
                ),
                SizedBox(
                  child: Divider(),
                  width: 300,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    width: 300,
                    foregroundDecoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Day ${controller.dayCnt + 1}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 250,
                              child: TextField(
                                controller: writeController,
                                maxLines: 10,
                                readOnly: true,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.removeCnt();
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    IconButton(
                        onPressed: () {
                          controller.addCnt();
                        },
                        icon: Icon(Icons.arrow_forward_ios))
                  ],
                )
              ],
            ),
          ));
    });
  }

  initPage(WriteVm controller) {
    // controller.dayCnt = 0;
    travelPlace = controller.location;
    day1 = controller.day1;
    day2 = controller.day2;
    travelMate = controller.mate;
    weather = controller.weather;

    String dbWriteList = controller.travelList;
    String formattedTravelList = formatTravelList(controller, dbWriteList);
    writeController.text = formattedTravelList;
  }

  String formatTravelList(WriteVm controller, String travelList) {
    travelItems = travelList.split('/../');
    controller.writeList = travelItems;
    return controller.writeList[controller.dayCnt];
  }
}
