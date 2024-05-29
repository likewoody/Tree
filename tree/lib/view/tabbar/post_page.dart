import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/view/common/appbar.dart';
import 'package:td_app/view/post/detail.dart';
import 'package:td_app/view/write/write.dart';
import 'package:td_app/view/write/write_view.dart';
import 'package:td_app/vm/front_part/vm_get_handler.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late VMGetHandler controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VMGetHandler();
    initData();
  }

  initData() async {
    await controller.searchPostDB();
    setState(() {});
  }

  selectDelete(index) async {
    await controller.deletePost(controller.posts[index].id);
    initData();
  }

  // ---- View ----
  Widget bodyView() {
    return InkWell(
      child: ListView.builder(
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: ActionPane(motion: const BehindMotion(), children: [
              SlidableAction(
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: '삭제',
                onPressed: (context) => selectDelete(index),
              )
            ]),
            child: SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    final box = GetStorage();
                    box.write("postId", controller.posts[index].id);
                    Get.to(WriteView())!.then((value) => initData());
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.posts[index].day1,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const Text(
                                "~",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                controller.posts[index].day2,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text(
                            controller.posts[index].location,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: CommonAppbar()),
      body: bodyView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.to(const Write())!.then((value) => controller.searchPostDB()),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green[50],
      ),
    );
  }
}
