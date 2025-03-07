

import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PopUp{
appController popController = Get.find();
  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static showOtpDialog(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter OTP"),
          content:  PinCodeTextField(
            appContext: context,
            length: 6, // Number of OTP digits
            obscureText: false,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 35,
              activeFillColor: Colors.white,
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            controller: otpController,
            onCompleted: (value) {
              print("Entered OTP: $value");
              Navigator.of(context).pop(); // Close the dialog on completion
            },
            onChanged: (value) {
              print("Current OTP value: $value");
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  static toastErrorMessage(String message){
    Fluttertoast.showToast(
      timeInSecForIosWeb: 2,
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

 static PopUpMessage(String message){
   Get.defaultDialog(
       title: "Welcome to Flutter Dev'S",
       middleText: "FlutterDevs is a protruding flutter app development company with "
           "an extensive in-house team of 30+ seasoned professionals who know "
           "exactly what you need to strengthen your business across various dimensions",
       backgroundColor: Colors.teal,
       titleStyle: const TextStyle(color: Colors.white),
       middleTextStyle: const TextStyle(color: Colors.white),
       radius: 30,
   );
 }

  static successMessage(String message) {
    Get.dialog(
      AlertDialog(
        title: Image.asset('assets/success.gif', height: 100, width: 100,),
        content: Text(message, textAlign: TextAlign.center,),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: color.WAbtnColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            child: const Text('Ok'),
          ).center(),
        ],
      ).center(),
    );
  }

  static failMessage(String message) {
    Get.dialog(
      AlertDialog(
        content: Text(message,textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: color.WAbtnColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            child: const Text('Ok'),
          ).center(),
        ],
      ).center(),
    );
  }

  static alertMessage(String message) {
    Get.dialog(
      AlertDialog(
        content: Text(message,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: color.WAbtnColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            child: const Text('Ok',style: TextStyle(color: Colors.white),),
          ).center(),
        ],
      ).center(),
    );
  }

}
