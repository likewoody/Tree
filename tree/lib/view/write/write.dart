import 'package:flutter/material.dart';

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
  late List<Widget> travelPlaceList;
  late List<Widget> travelDayList;
  int dayCnt = 1;

  @override
  void initState() {
    super.initState();
    travelPlaceController = TextEditingController();
    day1Controller = TextEditingController();
    day2Controller = TextEditingController();
    travelMateController = TextEditingController();
    weatherController = TextEditingController();
    travelPlaceList = [];
    travelDayList = [];
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 300,
                  color: Colors.amber,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Day $dayCnt"),
                          IconButton(
                              onPressed: () {
                                addPlaceWidget();
                              },
                              icon: Icon(Icons.add))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("장소 : "),
                          Container(
                            width: 200,
                            child: TextField(),
                          ),
                        ],
                      ),
                      Column(
                        children: travelPlaceList,
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: travelDayList,
              ),
              ElevatedButton(
                  onPressed: () {
                    addDayWidget();
                  },
                  child: Icon(Icons.add)),
              ElevatedButton(
                onPressed: () {},
                child: Text("업로드 하기"),
              )
            ],
          ),
        ),
      ),
    );
  }

  addPlaceWidget() {
    travelPlaceList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("장소 : "),
          Container(
            width: 200,
            child: TextField(),
          ),
        ],
      ),
    );
    setState(() {});
  }

  addDayWidget() {
    travelPlaceList = [];
    travelDayList.add(
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 300,
          color: Colors.amber,
          child: Column(
            children: [
              Row(
                children: [
                  Text("Day ${dayCnt}"),
                  IconButton(
                      onPressed: () {
                        addPlaceWidget();
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("장소 : "),
                  Container(
                    width: 200,
                    child: TextField(),
                  ),
                ],
              ),
              Column(
                children: travelPlaceList,
              ),
            ],
          ),
        ),
      ),
    );
    setState(() {});
  }
}
