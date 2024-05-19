import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/model/login/checkValidate.dart';
import 'package:td_app/view/login/findPw.dart';
import 'package:td_app/view/login/register.dart';
import 'package:td_app/view/common/tabbar.dart';
import 'package:td_app/vm/database_handler.dart';
import 'package:td_app/vm/vm_get_handler.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  // GetX Controller
  // final controller = Get.put(VMGetXLogin());
  final DatabaseHandler handler = DatabaseHandler();
  // focusing pw
  final FocusNode _pwFocus = FocusNode();
  // focusing pw
  final FocusNode _emailFocus = FocusNode();
  

  // Email & Password Check
  bool checkEmailPw = false;

  // GetStorage
  final box = GetStorage();


  // ---- Functions ----
  loginAlert(VMGetHandler controller){
    // print(controller.id);
    // print(controller.password);
    // print(controller.email);
    print(controller.checkActive);
    print(controller.checkPassword);
    if (controller.checkPassword && controller.checkActive) {
      // Get.ofAll 해야지 뒤로가기 버튼 안생김
      Get.offAll(const CommonTabbar());
      
      // VM에서 GetStorage store datas 만들기
      controller.changedStoredBox(null);
    }else{
      Get.defaultDialog(
        title: "경고",
        middleText: "정확하지 않은 아이디 비밀번호 입니다.",
        actions: [
          TextButton(
            onPressed: () => Get.back(), 
            child: const Text("확인")
          ),
        ]
      );
    } 
  }

  // Body View
  Widget bodyBuilder(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
              
            // Main Logo Image
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image.asset(
                "images/tree.png",
                width: 140,
                height: 140,
              ),
            ),
            // Main Logo Image
        
            // 로고 이미지와 tf 필드의 공간 만들기
            const SizedBox(
              height: 60,
            ),
              
              
            // App Title
            // const Padding(
            //   padding: EdgeInsets.all(15.0),
            //   child: Text(
            //     "트리",
            //     style: TextStyle(
            //       fontSize: 23
            //     ),
            //   ),
            // ),
            // App Title
            
        
            // 렌더링 될때 height가 자동으로 조절된다.
            // 이것은 TextFormField 가 SingleLineTextField를 상속받기 때문이다.
            // Email Textfield
            SizedBox(
              width: 280,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15,0,15,0),
                // 이게 없으면 밑에 표시가 나오지 않음
                child: Form(
                  // 이게 없으면 밑에 표시가 나오지 않음
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: emailController,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black
                        )
                      ),
                      hintText: "이메일",
                    ).copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    validator: (value) => CheckValidate().validateEmail(value ?? ""),
                  ),
                ),
              ),
            ),
            // Email Textfield
              
              
            // PW Textfield
            SizedBox(
              width: 280,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10,15,0),
                // 이게 없으면 밑에 표시가 나오지 않음
                child: Form(
                  // 이게 없으면 밑에 표시가 나오지 않음
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: pwController,
                    focusNode: _pwFocus,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
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
                    validator: (value) => CheckValidate().validatePassword(_pwFocus, value!),
                  ),
                ),
              ),
            ),
            // PW Textfield
            

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,30),
                  child: TextButton(
                    onPressed: () => Get.to(const Register()), 
                    child: const Text("회원가입")
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,30),
                  child: TextButton(
                    onPressed: () => Get.to(FindPassword()), 
                    child: const Text("비밀번호 찾기")
                  ),
                ),
              ],
            ),
            // Login Button
            // 이메일 비밀번호 확인을 위해 VM에서 Login Butotn만 관리
            GetBuilder<VMGetHandler>(
              init: VMGetHandler(),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () async{
                      controller.email = emailController.text;
                      controller.password = pwController.text;
                      await controller.checkEmailPasswordForLogin();
                      // login Alert 성공 or 실패
                      loginAlert(controller);
                    },
                    child: Container(
                      color: const Color.fromRGBO(3, 172, 19, 1),
                      width: 200,
                      height: 50,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(10,0,0,0),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0,12,10,12),
                          child: Text(
                            "로그인",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              
            ),
            // Login Button
              
            // // Google InkWell
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: InkWell(
            //     onTap: () async {
            //       // await authService.signInWithGoogle();
            //       print("clicked Google Logo");
            //     },
            //     child: Container(
            //       color: Colors.grey[200],
            //       width: 200,
            //       height: 50,
            //       child: Row(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.fromLTRB(30,0,0,0),
            //             child: Image.asset(
            //               "images/googleLogo.png",
            //               height: 25,
            //               fit: BoxFit.fill,
            //             ),
            //           ),
                  
            //           const Padding(
            //             padding: EdgeInsets.fromLTRB(10,0,0,0),
            //             child: Text(
            //               "구글 로그인",
            //               style: TextStyle(
            //                 color: Colors.black54,
            //                 fontSize: 20
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // // Google InkWell
              
            // // Naver InkWell
            // InkWell(
            //   onTap: () async {
            //     // await authService.signInWithGoogle();
            //     print("clicked Naver Logo");
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
              
            //       Image.asset(
            //         "images/naverLogo.png",
            //         width: 200,
            //         height: 50,
            //         fit: BoxFit.cover,
            //       ),
            //     ],
            //   ),
            // ),
            // // Naver InkWell
              
              
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = "123@12.34";
    pwController.text = "Qwer1234%";
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("login page test!!!!"),
        ),
        body: bodyBuilder()
      ),
    );
  }
}