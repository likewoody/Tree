import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/view/common/appbar.dart';

class Detail extends StatelessWidget {
  Detail({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    print(box.read("postId"));
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CommonAppbar(),
      ),
      body: Center(child: Text("detail page"),),
    );
  }
}