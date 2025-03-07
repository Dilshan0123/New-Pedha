
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/utils/WAWidgets.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';



class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {


  appController changePassController = Get.find();

  final oldPassKey = GlobalKey<FormState>();
  final newPassKey = GlobalKey<FormState>();
  final cPassKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }

  void _refreshPage(){
    changePassController.oldPassController.clear();
    changePassController.newPassController.clear();
    changePassController.confirmPassController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: SafeArea(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: (){
                                  Get.back();
                                },
                                child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                            Text("Change Password",
                                style: boldTextStyle(size: 24, color: Colors.white)),
                          ],
                        ).paddingAll(20),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.height,
                      Form(
                        key: oldPassKey,
                        child: AppTextField(
                          onChanged: (value){
                            oldPassKey.currentState!.validate();
                          },
                          validator: Validation.validationRequired,
                          decoration: waInputDecoration(
                            hint: 'Old Password',
                            prefixIcon: Icons.lock,
                            suffixIcon: changePassController.obscureText ? Icons.visibility_off : Icons.visibility,
                            onSuffixIconTap: () {
                              setState(() {
                                changePassController.obscureText = !changePassController.obscureText;  // Toggle password visibility
                              });
                            },
                          ),
                          obscureText: changePassController.obscureText,
                          textFieldType: TextFieldType.PASSWORD,
                          keyboardType: TextInputType.visiblePassword,
                          controller: changePassController.oldPassController,
                        ),
                      ),
                      10.height,
                      Form(
                        key: newPassKey,
                        child: AppTextField(
                          onChanged: (value){
                            newPassKey.currentState!.validate();
                          },
                          validator: Validation.validationRequired,
                          decoration: waInputDecoration(
                            hint: 'New Password',
                            prefixIcon: Icons.lock,
                            suffixIcon: changePassController.obscureText ? Icons.visibility_off : Icons.visibility,
                            onSuffixIconTap: () {
                              setState(() {
                                changePassController.obscureText = !changePassController.obscureText;  // Toggle password visibility
                              });
                            },
                          ),
                          obscureText: changePassController.obscureText,
                          textFieldType: TextFieldType.PASSWORD,
                          keyboardType: TextInputType.visiblePassword,
                          controller: changePassController.newPassController,
                        ),
                      ),
                      10.height,
                      Form(
                        key: cPassKey,
                        child: AppTextField(
                          onChanged: (value){
                            cPassKey.currentState!.validate();
                          },
                          validator: Validation.validationRequired,
                          decoration: waInputDecoration(
                            hint: 'Confirm Password',
                            prefixIcon: Icons.lock,
                            suffixIcon: changePassController.obscureText ? Icons.visibility_off : Icons.visibility,
                            onSuffixIconTap: () {
                              setState(() {
                                changePassController.obscureText = !changePassController.obscureText;  // Toggle password visibility
                              });
                            },
                          ),
                          obscureText: changePassController.obscureText,
                          textFieldType: TextFieldType.PASSWORD,
                          keyboardType: TextInputType.visiblePassword,
                          controller: changePassController.confirmPassController,
                        ),
                      ),
                      25.height,
                      AppButton(
                          color: color.WAbtnColor,
                          textColor: Colors.white,
                          shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          width:  MediaQuery.of(context).size.width,
                          onTap: () {
                            if(oldPassKey.currentState!.validate()
                                && newPassKey.currentState!.validate()
                                && cPassKey.currentState!.validate()){
                              changePassController.changePassApi("");
                            }else{
                              print("object");
                            }

                          },
                          child: changePassController.isLoading.value? const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()): const Text("Submit",style: TextStyle(color: Colors.white),)).paddingOnly(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1).paddingAll(16),
                    ],
                  ).paddingAll(20),
                ),

              ],
            ),
          ],
        ));
  }
}
