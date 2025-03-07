import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/WAWidgets.dart';

class WAForgotPassword extends StatefulWidget {
  const WAForgotPassword({super.key});

  @override
  State<WAForgotPassword> createState() => _WAForgotPasswordState();
}

class _WAForgotPasswordState extends State<WAForgotPassword> {


  appController ForgotController = Get.find();

  final loginKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                50.height,
                Text("Forgot Password", style: boldTextStyle(size: 24)),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        margin: const EdgeInsets.only(top: 55.0),
                        decoration: boxDecorationWithShadow(borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  50.height,
                                  Text("Login Id", style: boldTextStyle(size: 14)),
                                  8.height,
                                  Form(
                                    key: loginKey,
                                    child: AppTextField(
                                      validator: Validation.validationRequired,
                                      decoration: waInputDecoration(hint: 'Enter your login Id', prefixIcon: Icons.person_outline_outlined),
                                      textFieldType: TextFieldType.NAME,
                                      keyboardType: TextInputType.name,
                                      controller: ForgotController.fMobileNumberController,
                                      // focus: fullNameFocusNode,
                                      // nextFocus: emailFocusNode,
                                    ),
                                  ),
                                  10.height,
                                  Text("T Pin", style: boldTextStyle(size: 14)),
                                  8.height,
                                  Form(
                                    key: passwordKey,
                                    child: AppTextField(
                                      maxLength: 6,
                                      validator: Validation.validatePin,
                                      decoration: waInputDecoration(hint: 'Enter your t-pin', prefixIcon: Icons.person_outline_outlined),
                                      textFieldType: TextFieldType.PHONE,
                                      keyboardType: TextInputType.phone,
                                      controller: ForgotController.tPinPaymentCOntroller,
                                      // focus: fullNameFocusNode,
                                      // nextFocus: emailFocusNode,
                                    ),
                                  ),
                                  30.height,
                                  AppButton(
                                      text: "Proceed",
                                      color: color.WAbtnColor,
                                      textColor: Colors.white,
                                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      width: MediaQuery.of(context).size.width,
                                      onTap: () {
                                        if(loginKey.currentState!.validate()
                                            && passwordKey.currentState!.validate()){
                                          ForgotController.forgotPasswordApi();
                                        }

                                      }).paddingOnly(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
                                  30.height,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already have an account?', style: primaryTextStyle(color: Colors.grey)),
                                      4.width,
                                      Text('Log In here', style: boldTextStyle(color: Colors.black)),
                                    ],
                                  ).onTap(() {
                                    finish(context);
                                  }).center(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 100,
                      //   width: 100,
                      //   decoration: boxDecorationRoundedWithShadow(30),
                      //   child: Image.asset(
                      //     'assets/wa_app_logo.png',
                      //     height: 60,
                      //     width: 60,
                      //     fit: BoxFit.cover,
                      //   ),
                      // )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
