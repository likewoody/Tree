import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:td_app/model/login/checkValidate.dart';
import 'package:td_app/view/login/changePw.dart';
import 'package:td_app/vm/vm_get_login.dart';


class FindPassword extends StatelessWidget {
  FindPassword({super.key});

  final TextEditingController emailCon = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  bool _checkEmail = false;

  // SQLite를 통해서 where문으로 입력한 이메일을 찾는데
  // 자꾸 찾는게 잘 안된다. 되긴 했지만 반응이 조금씩 느리다.
  // 이거 처리가 필요함


  // ---- Alert ----
  alertEmail(controller) async{
    controller.email = emailCon.text;
    await controller.checkEmailForRegister();

    if (controller.checkEmailReturn == emailCon.text) {
      Get.defaultDialog(
        title: "알림",
        middleText: "이메일이 확인 되었습니다.",
        actions: [
          TextButton(
            onPressed: () {
              // showPasswordTextField = true;
              // body View에서만 이걸 보여줘도 되지 않는가?
              // 근데 alert창 이후에 바로 화면에 보여주려면 여기서 있어야 바로 화면에 보여진다.
              // showPasswordTextField ? secondTextField() : const SizedBox(width: 0, height: 0,);
              Get.back();
              Get.to(ChangePw());
            }, 
            child: const Text("확인")
          ),
        ]
      );
    }else {
      Get.defaultDialog(
        title: "경고",
        middleText: "이메일을 확인 해주세요.",
        actions: [
          TextButton(
            onPressed: () {Get.back();}, 
            child: const Text("확인")
          ),
        ]
      );
    }
  }
  
  // ---- View ----
  Widget bodyView(){
    return GetBuilder<VMGetXLogin>(
      init: VMGetXLogin(),
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0,0,180,5),
              child: Text("이메일"),
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  height: 100,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(80, 0, 0, 20),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: emailCon,
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: "이메일",
                          ).copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                          ),validator: (value) => CheckValidate().validateEmail(value ?? ""),
                          // Change가 발생하면 그리고 정규성이 통과됬을 때 alertCheck를 true로 바꾸고 alert 실행
                          onChanged: (value) async {
                            if (CheckValidate().validateEmail(value) == "") {
                              _checkEmail = true;
                              // print("check onfieldSubmitted");
                            }
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 140,
              // height: ,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,33),
                child: ElevatedButton(
                  onPressed: () {
                    _checkEmail ? alertEmail(controller) : null;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(60, 172, 19, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  
                  child: const Text(
                    "이메일 확인",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      // backgroundColor: Colors.grey
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 150,)
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find PW"),
      ),
      body: bodyView(),
    );
  }
}