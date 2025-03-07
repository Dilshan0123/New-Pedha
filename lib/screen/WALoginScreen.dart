
import 'dart:async';
import 'package:PedhaPay/screen/WAForgotPassword.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';



import '../utils/WAColors.dart';
import '../utils/WAWidgets.dart';

import 'WAVerificationScreen.dart';

class WALoginScreen extends StatefulWidget {
  static String tag = '/WALoginScreen';

  const WALoginScreen({super.key});

  @override
  WALoginScreenState createState() => WALoginScreenState();
}

class WALoginScreenState extends State<WALoginScreen> with TickerProviderStateMixin {
  var loginController = Get.put(appController());
  final _formKey = GlobalKey<FormState>();
  final mobileKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  bool _obscureText = true;

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  FocusNode desiredWidgetFocusNode = FocusNode();

  final Uri _url = Uri.parse('https://flutter.dev');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
                    Text("SIGN IN", style: boldTextStyle(size: 24)),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Text("LOGIN ID", style: boldTextStyle(size: 14)),
                                    8.height,
                                    Form(
                                      key: mobileKey,
                                      child: AppTextField(
                                        onChanged: (value){
                                          mobileKey.currentState!.validate();
                                          if(value.length == 10){
                                            FocusScope.of(context).requestFocus(desiredWidgetFocusNode);
                                          }
                                        },
                                        maxLength: 10,
                                        validator: Validation.validateContact,
                                        decoration: waInputDecoration(
                                          hint: 'ENTER LOGIN ID',
                                          prefixIcon: Icons.account_box,
                                        ),
                                        textFieldType: TextFieldType.PHONE,
                                        keyboardType: TextInputType.number,
                                        controller: loginController.loginIdController,
                                      ),
                                    ),
                                    16.height,
                                    Text("PASSWORD", style: boldTextStyle(size: 14)),
                                    8.height,
                                    Form(
                                      key: passwordKey,
                                      child: AppTextField(
                                        onChanged: (value) {
                                          passwordKey.currentState!.validate();
                                        },
                                        validator: Validation.validationRequired,
                                        decoration: waInputDecoration(
                                          hint: 'ENTER PASSWORD',
                                          prefixIcon: Icons.lock_outline,
                                          suffixIcon: _obscureText ? Icons.visibility_off : Icons.visibility,
                                          onSuffixIconTap: () {
                                            setState(() {
                                              _obscureText = !_obscureText;  // Toggle password visibility
                                            });
                                          },
                                        ),
                                        textFieldType: TextFieldType.PASSWORD,
                                        obscureText: _obscureText, // This properly hides/shows the text
                                        keyboardType: TextInputType.visiblePassword,
                                        controller: loginController.passwordController,
                                      )
                                    ),
                                    10.height,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min, // Shrink to fit content
                                            children: [
                                              Checkbox(
                                                value: loginController.isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    loginController.isChecked = value!;
                                                  });
                                                },
                                                visualDensity: VisualDensity.compact, // Reduces default padding
                                              ),
                                              const Text(
                                                'login by otp',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),

                                        InkWell(
                                            onTap: (){

                                              Get.to(WAForgotPassword());
                                            },
                                            child: Text("Forgot Password?", style: primaryTextStyle())),
                                      ],
                                    ),
                                    30.height,
                                    AppButton(
                                        color: Theme.of(context).primaryColor,
                                        textColor: Colors.white,
                                        shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                        width: MediaQuery.of(context).size.width,
                                        onTap: loginController.isLoading.value? null: (){
                                          if (mobileKey.currentState!.validate()
                                              && passwordKey.currentState!.validate()) {
                                            loginController.checkGps();
                                            loginController.loginApi();
                                            // loginController.loginApi();
                                          }
                                        },
                                        child: loginController.isLoading.value? AppButton(
                                          text: "Loading...",
                                          textColor: Colors.white,
                                          color: color.WAbtnColor,
                                          shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                          width:  MediaQuery.of(context).size.width,
                                          onTap: (){
                                              loginController.isLoading.value = false;
                                          },
                                        ) : const Text('Log In',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15))).paddingOnly(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
                                    30.height,
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 180,
                              decoration: boxDecorationRoundedWithShadow(30),
                              child: Image.asset("assets/appLogo.png").paddingOnly(left: 10,right: 10)
                          )
                        ],
                      ),
                    ),
                    16.height,
                  ],
                ),
              ),
            ),
          );
        }
        ),
      ),
    );
  }
}




