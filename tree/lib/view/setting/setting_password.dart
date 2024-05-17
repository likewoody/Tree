import 'package:flutter/material.dart';
import 'package:td_app/model/login/checkValidate.dart';
import 'package:td_app/view/common/appbar.dart';

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
  // var provider;
  String _userEmail = '';
  // bool _apiUser = false;
  // 비밀번호 키 때문에
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
      child: TextButton(
        onPressed: () {
            // if(_apiUser ) {
            //   provider.showWarnSanckBar();
            // } else{
            //   provider.formKey.currentState!.validate();
            //   _clickButton();
            // }
        }, 
        child: Text(
          '비밀번호 설정',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary
            ),
          ),
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
                  ElevatedButton(
                    child: const Text('비밀번호 변경하기'),
                    onPressed: (){
                      // if(apiUser ) {
                      //   provider.showWarnSanckBar();
                      // } else{
                      //   provider.formKey.currentState!.validate();
                      //   _clickButton();
                      // }
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


  _clickButton(){
    // provider.inputCurrentPassword = pwCon1.text;
    // provider.fNewPassword = pwCon2.text;
    // provider.sNewPassword =  pwCon3.text;
    // print('pwCon1.text : ${pwCon1.text}');
    // print('pwCon2.text : ${pwCon2.text}');
    // print('pwCon3.text : ${pwCon3.text}');
    // provider.curPasswordCheck();
    // if(provider.changePassword()){
    //   provider.showSuccessfulAlert();
    // };
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