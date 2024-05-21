import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:td_app/model/login/checkValidate.dart';
import 'package:td_app/vm/woody/vm_get_handler.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  late TextEditingController emailCon;
  late TextEditingController passwordCon;
  late TextEditingController passwordCon2;
  
  // 이메일 정규성 포커싱 
  late FocusNode _emailFocus;
  // 비밀번호 정규성 포커싱
  late FocusNode _pwFocus1;
  late FocusNode _pwFocus2;
  // 1번째 TextField가 정규성, 중복이 끝나면 true로 보여주기 위함
  late bool _showPasswordTextField;
  // email 인증이 끝나면 중복확인 버튼 비활성화
  late bool _isEmailDuplicated;
  // 상태관리용
  late VMGetHandler controller;
  // 정규성 체크 후 중복 확인 클릭
  late bool _duplicatedAlert;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailCon = TextEditingController();
    passwordCon = TextEditingController();
    passwordCon2 = TextEditingController();

    _emailFocus = FocusNode();
    _pwFocus1 = FocusNode();
    _pwFocus2 = FocusNode();
    _showPasswordTextField = false;
    // textFieldList = [firstTextField()];
    controller = VMGetHandler();
    _isEmailDuplicated = false;
    _duplicatedAlert = false;
  }

  // ---- Functions ----
  alertEmailCheck() async{
    controller.email = emailCon.text;
    await controller.checkEmailForRegister();
    if (controller.checkEmailReturn == emailCon.text){
      Get.defaultDialog(
        title: "경고",
        middleText: "중복된 이메일입니다.",
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
        middleText: "사용 가능한 이메일입니다.",
        actions: [
          TextButton(
            onPressed: () {
              _isEmailDuplicated = true;
              _showPasswordTextField = true;
              // body View에서만 이걸 보여줘도 되지 않는가?
              // 근데 alert창 이후에 바로 화면에 보여주려면 여기서 있어야 바로 화면에 보여진다.
              _showPasswordTextField ? secondTextField() : const SizedBox(width: 0, height: 0,);
              Get.back();
            }, 
            child: const Text("확인")
          ),
        ]
      );
    }
  }


  alertSignUp(int result){
    // if (testId == emailCon.text){
    if (result > 0){
      Get.defaultDialog(
        title: "알림",
        middleText: "회원가입이 완료되었습니다.",
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            }, 
            child: const Text("확인")
          ),
        ]
      );
    }else {
      Get.defaultDialog(
        title: "경고",
        middleText: "회원 가입 실패 하였습니다.",
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            }, 
            child: const Text("확인")
          ),
        ]
      );
    }
  }




  // ---- View ----
  Widget firstTextField() {
    return Column(
      children: [
        const SizedBox(height: 100),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 275, 5),
          child: Text("이메일"),
        ),
        Row(
          children: [
            SizedBox(
              width: 260,
              height: 80,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 15, 0),
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
                      onChanged: (value) {
                        if (CheckValidate().validateEmail(value) == "") {
                          _duplicatedAlert = true;
                          // print("check onfieldSubmitted");
                          
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                // height: ,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,33),
                  child: ElevatedButton(
                    onPressed: _isEmailDuplicated ? null : () {
                      _duplicatedAlert ? alertEmailCheck() : null;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(60, 172, 19, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    
                    
                    child: const Text(
                      "중복확인",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        // backgroundColor: Colors.grey
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget secondTextField(){
    setState(() {});
    // print("get in secondTextField $showPasswordTextField");
    return Center(
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 265, 5),
          child: Text("비밀번호"),
        ),
        // 비밀번호
        Row(
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
                    controller: passwordCon,
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
          height: 25,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 235, 5),
          child: Text("비밀번호 확인"),
        ),
        // 비밀번호 확인
        Row(
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
                    validator: (value) => CheckValidate().validatePassword2(_pwFocus2, value!, passwordCon.text, passwordCon2.text),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Password Textfield

        // 회원가입 버튼
        const SizedBox(
          width: 0,
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,33),
          child: ElevatedButton(
            onPressed: () async{
              
              controller.email = emailCon.text;
              controller.password = passwordCon.text;
              
              // 회원가입 SQLite 실행
              int result = await controller.userResigeter();
              // 로그인 성공시 alert
              print(result);
              alertSignUp(result);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(60, 172, 19, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            
            child: const Text(
              "회원가입",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                // backgroundColor: Colors.grey
              ),
            ),
          ),
        ),
      ],),
    
    );
  }

    
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
          
                firstTextField(),
                // Email TextField가 진행이 되면 Password TextField Show
                _showPasswordTextField ? secondTextField() : const SizedBox(width: 0, height: 0,)
              ]
            ),
          ),
        )
      ),
    );
  }
}