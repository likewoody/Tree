import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:td_app/view/common/appbar.dart';

class SetNickname extends StatelessWidget {
  const SetNickname({super.key});


  // ---- View ----
  Widget bodyView(){
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.fromLTRB(0,180,0,0),
            child: Column(

              children: [

                const Padding(
                  padding: EdgeInsets.fromLTRB(0,0,140,0),
                  child: Text("닉네임 설정"),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(50,10,0,0),
                  child: SizedBox(
                    width: 280,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "닉네임 입력",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))
                        )
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50,30,0,0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    }, 
                    child: const Text("닉네임 설정")
                  ),
                ),
              ],
            ),
          )
        ],
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
    );
  }
}