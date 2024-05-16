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
    dayCnt = 0;
    writeList = [""];
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
                    child: TextField(
                      controller: travelPlaceController,
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
                          controller: day1Controller,
                        ),
                      ),
                      const Text(" ~ "),
                      Container(
                        width: 100,
                        child: TextField(
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
                          Get.defaultDialog(title: "여행 첫날입니다.");
                        }
                        setState(() {});
                      },
                      child: Icon(Icons.remove)),
                  ElevatedButton(
                      onPressed: () {
                        saveCurrentDayText();
                        dayCnt++;
                        if (writeList.length <= dayCnt) {
                          writeList.add("");
                        }
                        writeController.text = writeList[dayCnt];
                        setState(() {});
                      },
                      child: Icon(Icons.add)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  saveCurrentDayText();
                  print(writeList);
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

  saveCurrentDayText() {
    if (writeList.length > dayCnt) {
      writeList[dayCnt] = writeController.text;
    } else {
      writeList.add(writeController.text);
    }
  }
}
