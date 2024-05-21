import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:td_app/model/login/checkValidate.dart';
import 'package:td_app/vm/woody/vm_get_handler.dart';

class ChangePw extends StatelessWidget {
  ChangePw({super.key});
  

  final TextEditingController passwordCon1 = TextEditingController();
  final TextEditingController passwordCon2 = TextEditingController();
  final FocusNode _pwFocus1 = FocusNode();
  final FocusNode _pwFocus2 = FocusNode();

  // ---- Alert ----
  alertPassword(controller) {
    if (passwordCon1.text != passwordCon2.text) {
      Get.defaultDialog(
        title: "경고",
        middleText: "비밀번호를 확인 해주세요.",
        actions: [
          TextButton(
            onPressed: () {Get.back();}, 
            child: const Text("확인")
          ),
        ]
      );
    }else {
      Get.defaultDialog(
        title: "알림",
        middleText: "비밀번호 변경이 완료 되었습니다.",
        actions: [
          TextButton(
            onPressed: () async{
              print(controller.email);
              controller.password = passwordCon2.text;
              await controller.changePassword();
              Get.back();
              Get.back();
              Get.back();
              
              // Get.to(ChangePw());
            }, 
            child: const Text("확인")
          ),
        ]
      );
    }
  }

  // ---- View ----
  Widget bodyView(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GetBuilder<VMGetHandler>(
        init: VMGetHandler(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 180,),
              // 비밀번호
              const Padding(
                padding: EdgeInsets.fromLTRB(0,0,120,5),
                child: Text("새로운 비밀번호"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 290,
                    // height: 500,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(38,0,45,0),
                      child: Form(
                        // 이게 없으면 밑에 표시가 나오지 않음
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: passwordCon1,
                          focusNode: _pwFocus1,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            ),
                            hintText: "비밀번호",
                          ).copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                          ),
                          // 정규성 검사
                          validator: (value) => CheckValidate().validatePassword(_pwFocus1, value!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0,0,130,5),
                child: Text("비밀번호 확인"),
              ),
              // 비밀번호 확인
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 290,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(38,0,45,0),
                      child: Form(
                        // 이게 없으면 밑에 표시가 나오지 않음
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          
                          controller: passwordCon2,
                          focusNode: _pwFocus2,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            ),
                            hintText: "비밀번호 확인",
                          ).copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                          ),
                          // 정규성 검사
                          validator: (value) => CheckValidate().validatePassword2(_pwFocus2, value!, passwordCon1.text, passwordCon2.text),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Password Textfield
              const SizedBox(height: 40,),
              SizedBox(
                width: 140,
                // height: ,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,33),
                  child: ElevatedButton(
                    onPressed: () {
                      // 정규성이 통과 되었을 때만 alert을 통해 중복확인 체크
                      alertPassword(controller);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(60, 172, 19, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    
                    child: const Text(
                      "비밀번호 변경",
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
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("새로운 비밀번호"),
      ),
      body: bodyView(),
    );
  }
}