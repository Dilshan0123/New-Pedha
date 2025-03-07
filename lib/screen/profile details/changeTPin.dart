import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/utils/WAWidgets.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';


class changeTPin extends StatefulWidget {
  const changeTPin({super.key});

  @override
  State<changeTPin> createState() => _changeTPinState();
}

class _changeTPinState extends State<changeTPin> {


  appController changeTPinController = Get.find();

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
    changeTPinController.oldTPinController.clear();
    changeTPinController.newTPinController.clear();
    changeTPinController.confirmTPinController.clear();
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
                            Expanded(
                              child: Text("Change T-Pin",
                                  style: boldTextStyle(size: 24, color: Colors.white)),
                            ),
                          ],
                        ).paddingAll(20),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.height,
                            Column(
                              children: [
                                Form(
                                  key: oldPassKey,
                                  child: AppTextField(
                                    maxLength: 6,
                                    onChanged: (value){
                                      oldPassKey.currentState!.validate();
                                    },
                                    validator: Validation.validationRequired,
                                    decoration: waInputDecoration(
                                      hint: 'Old T-Pin',
                                      prefixIcon: Icons.lock_clock_sharp,suffixIcon: changeTPinController.obscureText ? Icons.visibility_off : Icons.visibility,
                                      onSuffixIconTap: () {
                                        setState(() {
                                          changeTPinController.obscureText = !changeTPinController.obscureText;  // Toggle password visibility
                                        });
                                      },
                                    ),
                                    obscureText: changeTPinController.obscureText,
                                    textFieldType: TextFieldType.PASSWORD,
                                    keyboardType: TextInputType.phone,
                                    controller: changeTPinController.oldTPinController,
                                  ),
                                ),
                                10.height,
        
                                Form(
                                  key: newPassKey,
                                  child: AppTextField(
                                    maxLength: 6,
                                    onChanged: (value){
                                      newPassKey.currentState!.validate();
                                    },
                                    validator: Validation.validationRequired,
                                    decoration: waInputDecoration(
                                      hint: 'New T-Pin',
                                      prefixIcon: Icons.lock_clock_sharp,
                                      suffixIcon: changeTPinController.obscureText ? Icons.visibility_off : Icons.visibility,
                                      onSuffixIconTap: () {
                                        setState(() {
                                          changeTPinController.obscureText = !changeTPinController.obscureText;  // Toggle password visibility
                                        });
                                      },
                                    ),
                                    obscureText: changeTPinController.obscureText,
                                    textFieldType: TextFieldType.PASSWORD,
                                    keyboardType: TextInputType.phone,
                                    controller: changeTPinController.newTPinController,
                                  ),
                                ),
                                10.height,
        
        
                                Form(
                                  key: cPassKey,
                                  child: AppTextField(
                                    maxLength: 6,
                                    onChanged: (value){
                                      cPassKey.currentState!.validate();
                                    },
                                    validator: Validation.validationRequired,
                                    decoration: waInputDecoration(hint: 'Confirm T-Pin',
                                      prefixIcon: Icons.lock_clock_sharp,
                                      suffixIcon: changeTPinController.obscureText ? Icons.visibility_off : Icons.visibility,
                                      onSuffixIconTap: () {
                                        setState(() {
                                          changeTPinController.obscureText = !changeTPinController.obscureText;  // Toggle password visibility
                                        });
                                      },
                                    ),
                                    obscureText: changeTPinController.obscureText,
                                    textFieldType: TextFieldType.PASSWORD,
                                    keyboardType: TextInputType.phone,
                                    controller: changeTPinController.confirmTPinController,
                                  ),
                                ),
                                25.height,
                                AppButton(
                                    text: "Submit",
                                    color: color.WAbtnColor,
                                    textColor: Colors.white,
                                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    width:  MediaQuery.of(context).size.width,
                                    onTap: () {
                                      changeTPinController.changeTPinApi("");
        
                                      // PopUp.successMessage("Payment Successfully");
                                    }).paddingOnly(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1).paddingAll(16),
                              ],
                            ),
                          ],
                        ).paddingAll(20),
                      ],
                    ),
                  ),
                ),
        
              ],
            ),
          ],
        ));
  }
}
