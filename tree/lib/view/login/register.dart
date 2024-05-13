import 'package:flutter/material.dart';
import 'package:td_app/model/login/checkValidate.dart';

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
  Widget? buttonWidget;
  late bool showPasswordTextField;
  late bool show;
  // late List<Widget> textFieldList;


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
    showPasswordTextField = false;
    // textFieldList = [firstTextField()];
    
  }


  // ---- Functions ----
  Widget firstTextField() {
    return Column(
      children: [
        const SizedBox(height: 100),
        SizedBox(
          width: 280,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                ),
                validator: (value) => CheckValidate().validateEmail(value ?? ""),
                // Field가 완료 됬을 때
                onFieldSubmitted: (value) {
                  if (CheckValidate().validateEmail(value) != null) {
                    showPasswordTextField = true;
                    showPasswordTextField ? secondTextField() : const SizedBox(width: 0,);
                  }
                },
              ),
            ),
          ),
        ),
        // buttonWidget = ElevatedButton(
        //   onPressed: () {
        //     showSecondTextField = true;
        //     buttonWidget = null;
        //     setState(() {});
        //   },
        //   child: const Text("확인"),
        // ),
        
      ],
    );
  }

  Widget secondTextField(){
    setState(() {});
    print("get in secondTextField $showPasswordTextField");
    return Center(
      child: Column(children: [
        // const SizedBox(height: 200,),

        // 비밀번호
        SizedBox(
          width: 280,
          // height: 500,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,0),
            // 이게 없으면 밑에 표시가 나오지 않음
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
                validator: (value) => CheckValidate().validatePassword(_pwFocus1, value!),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),

        // 비밀번호 확인
        SizedBox(
          width: 280,
          // height: 500,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,0),
            // 이게 없으면 밑에 표시가 나오지 않음
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
                validator: (value) => CheckValidate().validatePassword2(_pwFocus2, value!, passwordCon.text, passwordCon2.text),
                // onFieldSubmitted: (value) {
                //   if (CheckValidate().validateEmail(value) != null) {

                //     // showPasswordTextField = true;
                //   }
                // }
              ),
            ),
          ),
        ),
        // Password Textfield

        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
          onPressed: () {
            
          }, 
          child: const Text("확인")
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
                showPasswordTextField ? secondTextField() : Center()
              ]
            ),
          ),
        )
      ),
    );
  }
}