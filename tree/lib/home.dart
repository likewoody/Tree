import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:td_app/view/login/login.dart';
import 'package:td_app/view/write/write.dart';
import 'package:td_app/vm/wrire/write_vm.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WriteVm());
    return Scaffold(
      appBar: AppBar(
        title: const Text("임의 Home 화면"),
      ),
      body: Center(
        child: Column(
          // 각자 페이지에 들어가서 작업 해주시면 됩니다~!
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Get.to(const Write()),
                child: const Text("소리님")),
            ElevatedButton(
                onPressed: () => Get.to(Login()), child: const Text("woody")),
          ],
        ),
      ),
    );
  }
}
