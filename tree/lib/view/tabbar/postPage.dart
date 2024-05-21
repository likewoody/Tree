import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/view/common/appbar.dart';
import 'package:td_app/view/post/detail.dart';
import 'package:td_app/view/write/write.dart';
import 'package:td_app/vm/woody/vm_get_handler.dart';

class PostPage extends StatelessWidget {
  PostPage({super.key});
  
  final List<Map> testList = [
                      // {"img":"images/dog.png", "content":"대구 여행", "date":"2022-11-12"},
                      // {"img":"images/cat.png", "content":"부산 여행", "date":"2022-11-12"},
                      // {"img":"images/cow.png", "content":"울산 여행", "date":"2022-11-12"},
                      // {"img":"images/bee.png", "content":"경주 여행", "date":"2022-11-12"},
                      // {"img":"images/tree.png", "content":"강원 여행", "date":"2022-11-12"}
  ];
  final box = GetStorage();
  // VMGetHandler vmHandler = VMGetHandler();
  // ---- Function ----
  formattingDays(day){
    return day.toString().replaceAll("-", ".").substring(2,10);
  }


  // ---- Textbutton Widget ----
  Widget btnText(data, double fontSize){
    return TextButton(
      onPressed: () => Get.to(const Detail()), 
      child: Text(
        data,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black
        ),
      )
    );
  }

  // ---- View ----
  Widget bodyView(){
    return GetBuilder(
      init: VMGetHandler(),
      builder: (controller) {
        return InkWell(
          // onTap: () => Get.to(const Detail()),
          child: FutureBuilder(
            future: controller.searchPostDB(),
            builder: (context, snapshot) {
              if (snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30,0,0,0),
                                child: Column(
                                  children: [
                                    btnText(formattingDays(snapshot.data![index].day1), 12),
                                    const Text("~", style: TextStyle(fontSize: 12),),
                                    btnText(formattingDays(snapshot.data![index].day2), 12),
                                  ],
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.fromLTRB(50,0,0,0),
                                child: btnText(snapshot.data![index].location, 24),
                                // child: TextButton(
                                //   onPressed: () => Get.to(const Detail()), 
                                //   child: Text(
                                //     snapshot.data![index].location,
                                //     style: const TextStyle(
                                //       fontSize: 24,
                                //       color: Colors.black
                                //     ),
                                //   )
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
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