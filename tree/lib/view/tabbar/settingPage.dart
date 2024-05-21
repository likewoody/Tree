import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/view/common/appbar.dart';
import 'package:td_app/view/login/login.dart';
import 'package:td_app/view/setting/enquire.dart';
import 'package:td_app/view/setting/enquireList.dart';
import 'package:td_app/view/setting/setting_nickname.dart';
import 'package:td_app/view/setting/setting_password.dart';
import 'package:td_app/vm/woody/vm_get_handler.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  // Property
  var provider;
  String userEmail = '';
  bool apiUser = false;
  final box = GetStorage();

  // 유저가 nickname을 설정하면 설정한 닉네임으로 사용 가능
  String userNickname = "test입니다.";

  // ************ View ************
  Widget bodyView(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
      
          userInfoSetPage(),
      
          // Divider
          const Divider(
            thickness: 1,
          ),
      
      
          updateInfoPage(),
      
          // Divider
          const Divider(
            thickness: 1,
          ),
      
          appInfoPage(),
              
          // Divider
          const Divider(
            thickness: 1,
          ),
              
          deletePage(),
        ],
      ),
    );
  }

  // 이메일, 가입일자, 가입 방법
  Widget userInfoSetPage(){
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          child: Row(
            children: [
              Text(
                '로그인 정보',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,0,0),
              child: Text(userNickname),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,20,0),
              child: TextButton(
                onPressed: () => _executeSignout(), 
                child: const Text('로그아웃')
              ),
            ),

          ],
        ),
      ],
    );
  }

  // ***************************************
  Widget updateInfoPage(){
    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20,15,0,0),
              child: Text(
                '개인정보 설정',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
                ),
              ),
            ),
          ],
        ),

        // 닉네임 설정
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20,5,0,5),
              child: Text('닉네임 설정'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,5,15,5),
              child : IconButton (
                onPressed: () async { 
                  await Get.to(SetNickname());
                },
                icon:const  Icon(Icons.arrow_forward_ios)
              ),
            ),
          ],
        ),

        // 비밀번호 설정 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20,5,0,5),
              child: Text('비밀번호 설정'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,5,15,5),
              child: IconButton(
                onPressed: () => Get.to(
                  const SetPassword()
                ), 
                icon:const  Icon(Icons.arrow_forward_ios)
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ***************************************
  Widget appInfoPage(){
    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20,15,0,0),
              child: Text(
                '도움',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
                ),
              ),
            ),
          ],
        ),
        // 문의하기
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20,5,0,5),
              child: Text('문의하기'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,5,15,5),
              child: IconButton(
                onPressed: () => Get.to(
                  // null
                  Enquire()
                ), 
                icon:const  Icon(Icons.arrow_forward_ios)
              ),
            ),
          ],
        ),
        // 문의내역
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20,5,0,5),
              child: Text('문의내역'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,5,15,5),
              child: IconButton(
                onPressed: () => Get.to(
                  // null
                  EnquireList()
                ), 
                icon:const  Icon(Icons.arrow_forward_ios)
              ),
            ),
          ],
        ),


        // 버전정보
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20,5,0,5),
              child: Text('버전정보'),
            ),
          ],
        ),


        const Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20,0,0,5),
              child: Text(
                '현재 1.0.0 / 최신 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
                ),
              ),
            ),
          ],
        ),


        // 서비스 이용약관
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20,5,0,5),
              child: Text('서비스 이용약관'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,5,15,0),
              child: IconButton(
                onPressed: () => Get.to(
                  null
                  // ServiceInfo()
                ), 
                icon:const  Icon(Icons.arrow_forward_ios)
              ),
            ),
          ],
        ),



        // 개인 정보 처리방침
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20,5,0,5),
              child: Text('개인 정보 처리방침'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,5,15,0),
              child: IconButton(
                onPressed: () => Get.to(
                  null
                  // PersonalInfo()
                ), 
                icon:const  Icon(Icons.arrow_forward_ios)
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ***************************************
  Widget deletePage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10,5,0,5),
          child: TextButton(
            onPressed: () {
              _deleteAlert();
            }, 
            child: const Text(
              '탈퇴하기',
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ),
        ),
      ],
    );
  }

  _deleteAlert() {
    Get.defaultDialog(
      title: '알림',
      middleText: '탈퇴 하시겠습니까?',
      actions: [
        TextButton(
          onPressed: () => Get.back(), 
          child: const Text('아니요')
        ),
        GetBuilder<VMGetHandler>(
          init: VMGetHandler(),
          builder: (controller) {
            return TextButton(
              onPressed: () async{
                await _executeDelete(controller);
                Get.offAll(
                  Login()
                );
              },
              child: const Text('예')
            );
          },
        ),
      ]
    );
  }

  _executeDelete(controller) async{
    await controller.deactiveUser();
    box.remove("userInfo");
    print("successfully deleted");
    
  }

  _executeSignout() {
    Get.defaultDialog(
      title: '알림',
      middleText: '로그아웃 되었습니다.',
      actions: [
        TextButton(
          onPressed: (){
            box.remove("userInfo");
            Get.offAll(
              // null
              Login()
            );
          }, 
          child: const Text('종료')
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    print(box.read('userInfo'));
    // box.read('apiUser') != null ? apiUser = true : apiUser = false;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CommonAppbar()
      ),
      body: bodyView(),
    );
  }
}