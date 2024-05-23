import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:td_app/view/common/appbar.dart';
import 'package:td_app/view/post/detail.dart';
import 'package:td_app/view/write/write.dart';
import 'package:td_app/vm/front_part/vm_get_handler.dart';

class PostPage extends StatelessWidget {
  PostPage({super.key});

  final VMGetHandler vmController = VMGetHandler();


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


  // ---- Delete Sliable ----
  selectDelete(controller, snapshot, index){
    print(snapshot.data![index].id);
    controller.deletePost(snapshot.data![index].id);
  }


  // ---- View ----
  Widget bodyView(){
    return InkWell (
      child: FutureBuilder(
          future: vmController.searchPostDB(),
          builder: (context, snapshot) {
            // return GetBuilder(
            //     init: VMGetHandler(),
            //     builder: (controller) {
                if (snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const BehindMotion(), 
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: '삭제',
                              onPressed: (context) => selectDelete(vmController, snapshot, index),
                            )
                          ]
                        ),
                        child: SizedBox(
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
                                        // const Text("~", style: TextStyle(fontSize: 12),),
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
                        ),
                      );
                    },
                  );
              } else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
          //   },
          // );
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
        // ?.then((value) async{
          // VMGetHandler vmController = VMGetHandler();
          // print("갔다가 올까?");
          // vmController.searchPostDB();
        // }),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green[50],
      ),
    );
  }
}