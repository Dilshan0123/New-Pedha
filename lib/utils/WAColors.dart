import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

appController colorController = Get.find();


class color{
  static const WAPrimaryColor = Color(0xFF19A0BE);
  static const WAAccentColor = Color(0xFF26C884);
  static const WACardColor = Color.fromRGBO(255,255,255, 1);
  static const WABackGroundColor2 = Color.fromRGBO(0,202,190,1);
  static const BackGroundColor3 = Color.fromRGBO(239,241,243,1);
  static const WASecondColor = Color.fromRGBO(222,226,235,1);
  static const WATextFieldColor = Color.fromRGBO(244,243,249,1);
  static const WAbtnColor = Color(0xFF00AFE5);
  static const WASecondryColor = Color(0xFF00AFE5);
}


class btn_Gradient{
  static const Gradient = LinearGradient(colors:
  [
    Color.fromRGBO(186, 245, 234, 1.0),
    Color.fromRGBO(237,218,238,1.000),
    Color.fromRGBO(254,159,117,1.000),
    Color.fromRGBO(255,107,138,1.000),
    Color.fromRGBO(255,170,163,1.000)
  ]
  );
}

class GradientColor{
  static const btn_gradient = Color.fromRGBO(254,159,117,1.000);
}

class Validation{
  static String? validateContact(value) {
    String patttern = r'^((\\+91-?)|0)?[6-9]{1}[0-9]{9}$';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }else if(value == '9999999999'){
      return 'Please enter valid mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    else return null;
  }

  static String? validatePin(value) {
    if(value!.isEmpty){
      return "* Requered";
    }
    else if (!RegExp(r'^[0-9]*[0-9]*$').hasMatch(value)) {
      return 'Please enter a valid pin';
    }
    else if(value!.length != 6){
      return 'Please enter 6 digit pin';
    }
    else {
      return null;
    }
  }

  static String? validatepassword(value) {
    if(value.isEmpty)
    {
      return "* Required";
    } else if(! RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(value)){
      return "Please enter valid strong password";
    }
    else if (value.length < 6) {
      return "Password should be atleast 6 degit";
    } else
      return null;
  }

  static String? validateEmail(value) {
    if(value!.isEmpty){
      return "* Requered";
    }
    else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    else {
      return null;
    }
  }
  static String? validateAadhar(value) {
    if(value!.isEmpty){
      return "* Requered";
    }
    else if (!RegExp(r'^[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}$').hasMatch(value)) {
      return 'Please enter a valid aadhar';
    }
    else {
      return null;
    }
  }



  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else if (value.startsWith('0')) {
      return 'Amount should not start with 0';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid amount';
    } else if (double.parse(value) <= 99) {
      return 'Amount should be greater than 100';
    } else {
      return null;
    }
  }



  static String? validateNumber(value) {
    if(value!.isEmpty){
      return "* Requered";
    }
    else if (!RegExp(r'^[0-9]*[0-9]*$').hasMatch(value)) {
      return 'Please enter a valid details ';
    }
    else {
      return null;
    }
  }
  static String? validateRchargeAmount(value) {
    if(value!.isEmpty){
      return "* Requered";
    }
    else if (!RegExp(r'^[0-9]*[0-9]*$').hasMatch(value)) {
      return 'Please enter a valid amount';
    }
     else if(double.parse(value).toInt() <= 9){
      return 'Amount should be greater then 10';
    }
    else {
      return null;
    }
  }


  static String? validateIfsc(value) {
    if(value!.isEmpty){
      return "* Requered";
    }
    else if (!RegExp(r'^[A-Z]*[A-Z][0-9]*$').hasMatch(value)) {
      return 'Please enter a valid details ';
    }
    else {
      return null;
    }
  }

  static String? validateName(value) {
    if(value!.isEmpty){
      return "* Requered";
    }
    else if (!RegExp(r"^[a-z A-Z 0-9]+$").hasMatch(value)) {
      return 'Please enter a valid details ';
    }
    else {
      return null;
    }
  }

   static String? validationRequired(value) {
    if(value.isEmpty){
      return "* Required";
    }
    else {
      return null;
    }
  }


  String? validatepincode(value) {
    if (value!.isEmpty) {
      return "* Required";
    } else if (value.length != 6) {
      return "Please enter your pincode";
    }  else
      return null;
  }
  String? validatearea(value) {
    if (value!.isEmpty) {
      return "* Required";
    } else {
      return null;
    }
  }

  String? validatem_pin(value) {
    if(value.isEmpty)
    {
      return "* Required";
    } else if(RegExp(r'^(?=.?[])(?=.?)(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}').hasMatch(value)){
      return "Please enter valid password";
    }
    else
      return null;
  }

  String? oldPassword(String? value) {
    if (value!.isEmpty) {
      return "* Required";
    }
    else if (value.length < 5) {
      return "Number should be greater than 10 digit allow";
    } else
      return null;
  }


  String? newPassword(String? value) {
    if (value!.isEmpty) {
      return "* Required";
    }
    else if (value.length < 5) {
      return "Number should be greater than 10 digit allow";
    } else
      return null;
  }

  String? referId(String? value) {
    if (value!.isEmpty) {
      return "* Required";
    }
    else {
      return null;
    }
  }
}
