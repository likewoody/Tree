import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/model/post/post.dart';
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


  // ---- Delete Sliable ----
  selectDelete(controller, snapshot, index){
    print(snapshot.data![index].id);
    controller.deletePost(snapshot.data![index].id);
  }


  // ---- View ----
  Widget bodyView(){
    return InkWell (
      child: FutureBuilder<List<Post>>(
          future: vmController.searchPostDB(),
          builder: (context, snapshot) {
            // vmController.searchPostDB();
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
                            child: GestureDetector(
                              onTap: () {
                                final box = GetStorage();
                                box.write("postId", vmController.posts[index].id);
                                Get.to(Detail());
                              },
                              child: Card(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(40,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            formattingDays(snapshot.data![index].day1),
                                            style: const TextStyle(
                                              fontSize: 14
                                            ),
                                          ),
                                          const Text("~", style: TextStyle(fontSize: 12),),
                                          Text(
                                            formattingDays(snapshot.data![index].day2),
                                            style: const TextStyle(
                                              fontSize: 14
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(30,0,0,0),
                                      child: Text(
                                        snapshot.data![index].location,
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
        onPressed: () => Get.to(const Write())!.then((value) => vmController.searchPostDB()),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green[50],
      ),
    );
  }
}