import 'package:flutter/material.dart';
import 'package:td_app/model/login/checkValidate.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final FocusNode focusPW = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login page test!!!!"),
      ),
      body: bodyBuilder()
    );
  }

  // ---- View ----
  Widget bodyBuilder(){
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Main Logo Image
          SizedBox(
            height: 200,
            child: Image.asset(
              "images/tree.png",
              width: 140,
              height: 100,
            ),
          ),
          // Main Logo Image


          // App Title
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "트리",
              style: TextStyle(
                fontSize: 23
              ),
            ),
          ),
          // App Title

          // ID Textfield
          SizedBox(
            width: 280,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15,50,15,0),
              child: TextFormField(
                controller: idController,
                focusNode: focusPW,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "아이디",
                ).copyWith(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                ),
                // validator: (value) => CheckValidate().validatePassword(focusPW, value!),
              ),
            ),
          ),
          // ID Textfield



          // PW Textfield
          SizedBox(
            width: 280,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: idController,
                focusNode: focusPW,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "비밀번호",
                ).copyWith(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                ),
                validator: (value) => CheckValidate().validatePassword(focusPW, value!),
              ),
            ),
          ),
          // PW Textfield

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
      ),
    );
  }
}