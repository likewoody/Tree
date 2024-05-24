import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:td_app/view/tabbar/post_page.dart';
import 'package:td_app/view/write/write_view.dart';
import 'package:td_app/vm/wrire/write_vm.dart';

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
  late int day1Select;
  late int day2Select;
  late int travelDay;
  late int dayCnt;
  late bool dayisSelect;

  @override
  void initState() {
    super.initState();
    travelPlaceController = TextEditingController();
    day1Controller = TextEditingController();
    day2Controller = TextEditingController();
    travelMateController = TextEditingController();
    weatherController = TextEditingController();
    writeController = TextEditingController();
    writeList = [""];
    day1Select = day1Select = int.parse(
        '${DateTime.now().year % 100}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().day.toString().padLeft(2, '0')}');
    day2Select = int.parse(
        '${DateTime.now().year % 100}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().day.toString().padLeft(2, '0')}');
    ;
    travelDay = 0;
    dayCnt = 0;
    dayisSelect = false;
  }

  Widget dayWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 270,
        foregroundDecoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Text("Day ${dayCnt + 1}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 40,
                      child: Container(
                        height: 30,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: travelPlaceController,
                          decoration: InputDecoration(
                            hintText: "어디로 여행을 다녀오셨나요?",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                          ),
                        ),
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
                    Row(
                      children: [
                        Container(
                          width: 140,
                          height: 40,
                          child: TextField(
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "여행 첫째날",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0)),
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
                                          setState(() {
                                            day1Select = int.parse(
                                                '${value.year % 100}${value.month.toString().padLeft(2, '0')}${value.day.toString().padLeft(2, '0')}');
                                          });
                                        },
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        day1Controller.text =
                                            changeDayText(day1Select);
                                        Get.back();
                                      },
                                      child: Text("선택"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            controller: day1Controller,
                          ),
                        ),
                        const Text(" ~ "),
                        Container(
                          width: 140,
                          height: 40,
                          child: TextField(
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "여행 마지막날",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0)),
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
                                          setState(() {
                                            day2Select = int.parse(
                                                '${value.year % 100}${value.month.toString().padLeft(2, '0')}${value.day.toString().padLeft(2, '0')}');
                                          });
                                        },
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        day2Controller.text =
                                            changeDayText(day2Select);
                                        Get.back();
                                        alertDateSelect();
                                        dayisSelect = true;
                                      },
                                      child: Text("선택"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            controller: day2Controller,
                          ),
                        ),
                      ],
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
                      width: 300,
                      height: 40,
                      child: TextField(
                        controller: travelMateController,
                        decoration: InputDecoration(
                          hintText: "함께 여행간 사람은 누구인가요?",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                        ),
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
                      width: 300,
                      height: 40,
                      child: TextField(
                        controller: weatherController,
                        decoration: InputDecoration(
                          hintText: "날씨는 어땠나요?",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(children: [
                IconButton(
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
                  icon: Icon(Icons.arrow_back_ios),
                ),
                dayWidget(),
                IconButton(
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
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ]),
              ElevatedButton(
                onPressed: () {
                  var stringWriteList = "";
                  stringWriteList = writeList.join('/../');
                  var vm = WriteVm();
                  vm.insertWrite(
                      travelPlaceController.text,
                      day1Controller.text,
                      day2Controller.text,
                      travelMateController.text,
                      weatherController.text,
                      stringWriteList);
                  print(stringWriteList);
                  Get.offAll(PostPage());
                },
                child: Text("업로드 하기"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(WriteView());
                  },
                  child: Text('view이동'))
            ],
          ),
        ),
      ),
    );
  }

  saveCurrentDayText() {
    if (writeList.length > dayCnt) {
      writeList[dayCnt] = writeController.text;
    } else {
      writeList.add(writeController.text);
    }
  }

  alertDateSelect() {
    if (day2Select < day1Select) {
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
      if (day1Select == day2Select) {
        travelDay = 0;
      } else {
        travelDay = day2Select - day1Select;
      }
    }
  }

  changeDayText(int daySelect) {
    var year = daySelect.toString().substring(0, 2);
    var month = daySelect.toString().substring(2, 4);
    var day = daySelect.toString().substring(4, 6);

    return "${year}-${month}-${day}";
  }
}
