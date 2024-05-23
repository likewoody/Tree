import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/model/login/checkValidate.dart';
import 'package:td_app/view/common/appbar.dart';
import 'package:td_app/vm/front_part/vm_get_handler.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {

  // ---- Property ----
  final TextEditingController _pwCon1 = TextEditingController();
  final TextEditingController _pwCon2 = TextEditingController();
  final TextEditingController _pwCon3 = TextEditingController();
  final FocusNode _pwFocus1 = FocusNode();
  final FocusNode _pwFocus2 = FocusNode();
  final FocusNode _pwFocus3 = FocusNode();
  // 비밀번호 키 때문에
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  // ---- Function ----
  changedPassword(VMGetHandler controller) async{
    final box = GetStorage();
    final userInfo = box.read("userInfo");
    
    if (_pwCon1.text == _pwCon3.text){
      alertMessage("현재 비밀번호와 새로운 \n비밀번호를 다르게 입력하세요.", 1);
    }else if (_pwCon1.text == userInfo["password"] && _pwCon2.text == _pwCon3.text) {
      // VM에 새로운 비밀번호 알려주기 넣어주기
      controller.password = _pwCon3.text;

      // 먼저 실행함으로써 밑에 changePassword 함수에 인자를 안주고 storedbox 안에서 정보를 준다.
      await controller.changedStoredBox(userInfo);
      // print("check passwor ${userInfo["password"]}");
      // print("check passwor 2${controller.password}");
      await controller.changePassword();
      
      alertMessage("비밀번호가 변경 되었습니다.", 2);
    }else{
      alertMessage("비밀번호를 확인 해주세요.", 1);
    }
  }

  // ---- Alert ----
  alertMessage(String text, int cnt){
    // cnt는 Get.back()이 몇번 실행되야 하는지
    switch (cnt) {
      case 1:
        Get.defaultDialog(
          title: "알림",
          middleText: text,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("확인")
            ),
          ]
        );
      case 2:
        Get.defaultDialog(
          title: "알림",
          middleText: text,
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
    }
  }



  // ---- View 1 ----
  Widget _firstBodyView(context){
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _secondBodyView()
      ),
      bottomNavigationBar: Container(
      
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
      ),
      height: 80,
      child: GetBuilder<VMGetHandler>(
        builder: (controller) {
          return TextButton(
            onPressed: () {
                changedPassword(controller);
            }, 
            child: Text(
              '비밀번호 설정',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiary
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  // ---- View 2 ----
  Widget _secondBodyView(){
    // return StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //           .collection('user')
    //           // .orderBy(field),
    //           .where('email', isEqualTo: userEmail)
    //           .snapshots(),
    //   builder: (context, snapshot) {
    //     if (! snapshot.hasData) {
    //       return const Center(child: CircularProgressIndicator(),);
    //     }
    //     final documents = snapshot.data!.docs;
    //     // 현재 비밀번호 확인
    //     try {
    //       if(documents[0].get('password').isEmpty) {
    //         Get.back();
    //         provider.showWarnSanckBar();
    //       } else {
    //         provider.currentPassword = documents[0].get('password');
    //       }
    //     } catch (e) {
    //       apiUser = true;
    //       e.printError();
    //     }
    //     print(apiUser);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0,60,0,0),
      child: Column(
        children: [
          // current password
          Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  _thirdBodyView(),
                  GetBuilder<VMGetHandler>(
                    init: VMGetHandler(),
                    builder: (controller) {
                      return ElevatedButton(
                      child: const Text('비밀번호 변경하기'),
                        onPressed: (){
                          changedPassword(controller);
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _thirdBodyView(){
    return Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0,20,240,0),
            child: Text('현재 비밀번호'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
              child: SizedBox(
                height: 80,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: _pwCon1,
                    focusNode: _pwFocus1,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    // readOnly: _apiUser,
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
              )
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0,0,230,0),
            child: Text('새로운 비밀번호'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 15),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: _pwCon2,
                  focusNode: _pwFocus2,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  // readOnly: _apiUser,
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
                  validator: (value) => CheckValidate().validatePassword(_pwFocus2, value!),
                ),
              )
            ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0,20,240,0),
            child: Text('비밀번호 확인'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 40),
              child: SizedBox(
                height: 80,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: _pwCon3,
                    focusNode: _pwFocus3,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    // readOnly: _apiUser,
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
                    validator: (value) => CheckValidate().validatePassword2(_pwFocus3, value!, _pwCon2.text, _pwCon3.text),
                  ),
                ),
              )
          ),
        ],  
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80), 
        child: CommonAppbar()
      ),
      body: _firstBodyView(context),
    );
  }
}