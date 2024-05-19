import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Write extends StatefulWidget {
  const Write({super.key});

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  late TextEditingController travelPlaceController;
  late TextEditingController day1Controller;
  late TextEditingController day2Controller;
  late TextEditingController travelMateController;
  late TextEditingController weatherController;
  late TextEditingController writeController;
  late List<String> writeList;
  late DateTime day1Select;
  late DateTime day2Select;
  late int travelDay;
  late int dayCnt;

  @override
  void initState() {
    super.initState();
    travelPlaceController = TextEditingController();
    day1Controller = TextEditingController();
    day2Controller = TextEditingController();
    travelMateController = TextEditingController();
    weatherController = TextEditingController();
    writeController = TextEditingController();
    writeList = [""]; // 여행 기록 저장할 리스트
    day1Select = DateTime.now(); // 여행의 첫째날
    day2Select = DateTime.now(); // 여행의 마지막날
    travelDay = 0; // 여행 일수
    dayCnt = 0; // 여행 기록하는 곳에 출력할 숫자
  }

  Widget dayWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 300,
        color: Colors.amber,
        child: Column(
          children: [
            Text("Day ${dayCnt + 1}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: TextField(
                    controller: writeController,
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("write page test!!!!"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("여행지 : "),
                  Container(
                    width: 200,
                    child: Container(
                      height: 30,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: travelPlaceController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("여행 기간 :"),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            Get.defaultDialog(
                                title: "날짜를 선택해주세요",
                                content: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        initialDateTime: DateTime.now(),
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (value) {
                                          day1Select = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          day1Controller.text = "${day1Select}";
                                          Get.back();
                                        },
                                        child: Text("선택"))
                                  ],
                                ));
                            // ****************** SizedBox 안해주면 size error 발생 ******************
                          },
                          controller: day1Controller,
                        ),
                      ),
                      const Text(" ~ "),
                      Container(
                        width: 100,
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            Get.defaultDialog(
                                title: "날짜를 선택해주세요",
                                content: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        initialDateTime: DateTime.now(),
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (value) {
                                          day2Select = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          day2Controller.text = "${day2Select}";
                                          Get.back();
                                          alertDateSelect();
                                        },
                                        child: Text("선택"))
                                  ],
                                ));
                            // ****************** SizedBox 안해주면 size error 발생 ******************
                          },
                          controller: day2Controller,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("여행 메이트 : "),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: travelMateController,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("날씨 : "),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: weatherController,
                    ),
                  ),
                ],
              ),
              dayWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (dayCnt > 0) {
                          saveCurrentDayText();
                          dayCnt--;
                          writeController.text = writeList[dayCnt];
                        } else {
                          Get.defaultDialog(
                            barrierDismissible: false,
                            title: "경고",
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("첫째날의 여행 기록을 작성해 주세요"),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                        setState(() {});
                      },
                      child: Icon(Icons.remove)),
                  ElevatedButton(
                      onPressed: () {
                        saveCurrentDayText();
                        if (dayCnt < travelDay) {
                          dayCnt++;
                          if (writeList.length <= dayCnt) {
                            writeList.add("");
                          }
                          writeController.text = writeList[dayCnt];
                        } else {
                          Get.defaultDialog(
                            barrierDismissible: false,
                            title: "경고",
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("여행 기록을 추가하고 싶으시면\n여행 일자를 다시 선택해 주세요."),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                        setState(() {});
                      },
                      child: Icon(Icons.add)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  saveCurrentDayText();
                  Get.back();
                },
                child: Text("업로드 하기"),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 리스트에 기록일지를 추가해줄 함수
  saveCurrentDayText() {
    if (writeList.length > dayCnt) {
      writeList[dayCnt] = writeController.text;
    } else {
      writeList.add(writeController.text);
    }
  }

  // 여행 첫째날 보다 여행 마지막날이 더 전일 시 alert창 띄워주는 함수
  alertDateSelect() {
    if (day2Select.isBefore(day1Select)) {
      Get.defaultDialog(
        barrierDismissible: false,
        title: "경고",
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("날짜를 다시 선택해 주세요"),
            SizedBox(height: 20), // 적절한 간격을 추가
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      day2Controller.text = "";
    } else {
      travelDay = day2Select.difference(day1Select).inDays + 1;
      print(travelDay);
    }
  }
}
