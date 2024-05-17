import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:td_app/view/common/appbar.dart';
import 'package:td_app/view/post/detail.dart';
import 'package:td_app/view/write/write.dart';

class PostPage extends StatelessWidget {
  PostPage({super.key});

  // 데이터만 SQLite를 통해서 받아오면 된다.
  final List<Map> testList = [{"img":"images/dog.png", "content":"대구 여행", "date":"2022-11-12"},
                      {"img":"images/cat.png", "content":"부산 여행", "date":"2022-11-12"},
                      {"img":"images/cow.png", "content":"울산 여행", "date":"2022-11-12"},
                      {"img":"images/bee.png", "content":"경주 여행", "date":"2022-11-12"},
                      {"img":"images/tree.png", "content":"강원 여행", "date":"2022-11-12"}
  ];
  // final box = GetStorage();

  // ---- View ----
  Widget bodyView(){
    // print(box.read('userInfo'));
    // print(box.read('email'));
    // print(box.read('password'));
    return InkWell(
      onTap: () => Get.to(const Detail()),
      child: ListView.builder(
        itemCount: testList.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.brown[50],
            height: 80,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Padding(
                    // padding: const EdgeInsets.fromLTRB(40, 0, 80, 0),
                    Image.asset(
                      testList[index]["img"],
                      width: 35,
                      height: 35,
                    ),
                  // ),
                  Text(
                    testList[index]["content"],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  
                  Text(
                    testList[index]["date"],
                    style: const TextStyle(
                      fontSize: 14
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80), 
        child: CommonAppbar()
      ),
      body: bodyView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(const Write()),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green[50],
      ),
    );
  }
}