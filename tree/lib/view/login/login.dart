import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/model/login/checkValidate.dart';
import 'package:td_app/view/login/register.dart';
import 'package:td_app/view/start/start.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  // GetX Controller
  // final controller = Get.put(VMGetXLogin());

  // focusing pw
  final FocusNode _pwFocus = FocusNode();
  // focusing pw
  final FocusNode _emailFocus = FocusNode();
  

  // Email & Password Check
  bool checkEmailPw = false;

  // GetStorage
  final box = GetStorage();

  // Storage로 보낼 정보
  var willSendDatas = {};




  checkEmailPassword(snapshot) {
    // 보낼 데이터 초기화
    willSendDatas = {};


    final documents = snapshot.data!.docs;
    // Email & Password Check
    documents.forEach((data) { 
      if (emailController.text == data['email'] && pwController.text == data['password']) {
        checkEmailPw = true;
        // 보낼 데이터 맵으로 만듦
        Map<String, String> map ={
          "nickname":data['nickname'],
          "id":data.id
        };
        // 맵으로 보내기
        willSendDatas.addAll(map);
      } else{
        checkEmailPw = false;
      }
                  
    });
  }

  @override
  Widget build(BuildContext context) {
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





  // // ---- GetBuilder ----
  // Widget bodyGetBuilder(){
  //   return GetBuilder<VMGetXLogin>(
  //     builder: (controller) {
  //       return bodyView();
  //     },
  //   );
  // }






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
              height: 60,
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
              height: 50,
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
            
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,30),
              child: TextButton(
                
                onPressed: () => Get.to(const Register()), 
                child: const Text("회원가입")
              ),
            ),


            // Login Button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async{
                  // await authService.signInWithGoogle();
                  String test;
                  
                  if (checkEmailPw) {
                    await box.write("infoBox", willSendDatas);
                    Get.to(const Start());

                    print("succesfully in");
                  }else{
                    print("failed...");
                  }
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
            ),
            // Login Button
              
            // Google InkWell
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async {
                  // await authService.signInWithGoogle();
                  print("clicked Google Logo");
                },
                child: Container(
                  color: Colors.grey[200],
                  width: 200,
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30,0,0,0),
                        child: Image.asset(
                          "images/googleLogo.png",
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                      ),
                  
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10,0,0,0),
                        child: Text(
                          "구글 로그인",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Google InkWell
              
            // Naver InkWell
            InkWell(
              onTap: () async {
                // await authService.signInWithGoogle();
                print("clicked Naver Logo");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              
                  Image.asset(
                    "images/naverLogo.png",
                    width: 200,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            // Naver InkWell
              
              
          ],
        )
      ),
    );
  }
}