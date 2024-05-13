import 'package:flutter/material.dart';

class CheckValidate{

  // GetX 사용하기 위한 모델
  String emailHelper;
  String pwHelper;

  // GetX 사용하기 위한 모델
  CheckValidate({
    this.emailHelper = "",
    this.pwHelper = ""
  });

  String validateEmail(String value){
    if (value.isEmpty) {
      return '이메일을 입력하세요.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return '잘못된 이메일 형식입니다.';
    }return '';
  }

  String validatePassword(FocusNode focusNode, String value){
    if(value.isEmpty){
      focusNode.requestFocus();
      return '비밀번호를 입력하세요.';
    }else {
      Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      RegExp regExp = RegExp(pattern.toString());
      if(!regExp.hasMatch(value)){
        focusNode.requestFocus();
        return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
      }else{
        return '';
      }
    }
  }

  String validatePassword2(FocusNode focusNode, String value, String firstPassword, String secondPassword){
    if(value.isEmpty){
      focusNode.requestFocus();
      return '비밀번호를 입력하세요.';
    }else {
      Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      RegExp regExp = RegExp(pattern.toString());
      if(!regExp.hasMatch(value)){
        focusNode.requestFocus();
        return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
      }else if (firstPassword != secondPassword){
        return '비밀번호가 일치하지 않습니다.';
      }else {
        return '';
      }
    }
  }
}
