import 'dart:async';
import 'package:PedhaPay/model/Pedha%20Pay%20Model/Recharge/PlanModel.dart';
import 'package:PedhaPay/model/Pedha%20Pay%20Model/Recharge/ReOperatorModel.dart';
import 'package:PedhaPay/screen/Recharge/mobileRechargePlan.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/WAWidgets.dart';
import 'Provider.dart';

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({super.key});

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {


  appController mobileRechargeController = Get.find();

  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 50), () {
      mobileRechargeController.getRechargeOperatorApi("");
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }

  void _refreshPage() {
    // Clear the controllers or reload necessary data
    mobileRechargeController.mobileNumberController.clear();
    mobileRechargeController.mobileOperatorController.clear();
    mobileRechargeController.mobileAmountController.clear();
    mobileRechargeController.isVisiblePlanBtn.value = false; // Reset visibility if needed
  }

  FocusNode OperatorFocus = FocusNode();
  FocusNode AmountFocus = FocusNode();
  FocusNode btnFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final R_MobileKey = GlobalKey<FormState>();
  final R_OperatorKey = GlobalKey<FormState>();
  final R_AmountKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        mobileRechargeController.mobileNumberController.clear();
        mobileRechargeController.mobileAmountController.clear();
        mobileRechargeController.mobileOperatorController.clear();
        mobileRechargeController.isVisiblePlanBtn.value = false;
        return true;
      },
      child: Scaffold(
        appBar:  AppBar(
          title: const Text("Mobile Recharge",style: TextStyle(color: Colors.white),),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
          body: Obx(() {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: color.WACardColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.height,
                                  Text("Mobile Number", style: boldTextStyle(size: 14)),
                                  8.height,
                                  Form(
                                    key: R_MobileKey,
                                    child: AppTextField(
                                      onChanged: (value){
                                        R_MobileKey.currentState!.validate();
                                      },
                                      maxLength: 10,
                                      validator: Validation.validateContact,
                                      decoration: waInputDecoration(hint: 'Mobile Number', prefixIcon: Icons.account_box),
                                      textFieldType: TextFieldType.PHONE,
                                      keyboardType: TextInputType.number,
                                      controller: mobileRechargeController.mobileNumberController,
                                    ),
                                  ),
                                  16.height,
                                  Text("Operator", style: boldTextStyle(size: 14)),
                                  8.height,
                                  Form(
                                    key: R_OperatorKey,
                                    child: AppTextField(
                                      validator: Validation.validationRequired,
                                      focus: OperatorFocus,
                                      decoration: waInputDecoration(
                                        hint: 'operator',
                                        prefixIcon: Icons.sim_card_rounded,
                                      ),
                                      textFieldType: TextFieldType.EMAIL,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: mobileRechargeController.mobileOperatorController,
                                      // focus: emailFocusNode,
                                      // nextFocus: passWordFocusNode,
                                      onFieldSubmitted: (value){
                                        FocusScope.of(context).requestFocus(AmountFocus);
                                      },
                                      onTap: () async {
                                        // mobileRechargeController.getOperatorApi();
                                        AmountFocus.requestFocus();
                                        RechargeOperatorDataModel result = await Get.to(const DTHProvider());
                                        debugPrint(result.providerName);
                                        mobileRechargeController.isVisiblePlanBtn.value = true;
                                        mobileRechargeController.operator = result.providerAlias!.toString();
                                        mobileRechargeController.mobileOperatorController.text = result.providerName.toString();
                                        mobileRechargeController.providerName = result.providerName.toString();
                                        List<String> parts = result.providerAlias!.split("|");
                                        mobileRechargeController.operator = parts[0];
                                                                              // Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  16.height,
                                  Text("Amount", style: boldTextStyle(size: 14)),
                                  8.height,
                                  Column(
                                    children: [
                                      Form(
                                        key: R_AmountKey,
                                        child: AppTextField(
                                          onChanged: (value){
                                            R_AmountKey.currentState!.validate();
                                          },
                                          maxLength: 4,
                                          validator: Validation.validateRchargeAmount,
                                          focus: AmountFocus,
                                          decoration: waInputDecoration(hint: 'amount ', prefixIcon: Icons.currency_rupee),
                                          suffixIconColor: color.WAPrimaryColor,
                                          textFieldType: TextFieldType.PHONE,
                                          // isPassword: true,
                                          // keyboardType: TextInputType.visiblePassword,
                                          controller: mobileRechargeController.mobileAmountController,
                                          onFieldSubmitted: (value){
                                            FocusScope.of(context).requestFocus(btnFocus);
                                          },

                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: ()async{
                                            if(R_MobileKey.currentState!.validate()
                                                && R_OperatorKey.currentState!.validate()
                                            ){
                                              // mobileRechargeController.rechargeViewPlan("");
                                              mobileRechargeController.MobileNumber = mobileRechargeController.mobileNumberController.text;
                                              Records result = await   Get.to(const rechargePlane());
                                              mobileRechargeController.operator = result.toString();
                                              mobileRechargeController.mobileAmountController.text = result.rs.toString();
                                              FocusScope.of(context).requestFocus(btnFocus);
                                            
                                            }

                                          },
                                          child: const Text("View Plan", style: TextStyle(
                                            color: Colors.blue,
                                          ),),
                                        ),).paddingOnly(right: 5)
                                    ],
                                  ),
                                  16.height,
                                  AppButton(
                                      text: "Submit",
                                      // color: Color(0xFF19A0BE),
                                      color: color.WAbtnColor,
                                      textColor: Colors.white,
                                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      width:  MediaQuery.of(context).size.width,
                                      onTap: () {
                                        if (R_MobileKey.currentState!.validate()
                                            && R_OperatorKey.currentState!.validate()
                                            && R_AmountKey.currentState!.validate()) {
                                          mobileRechargeController.MobileNumber = mobileRechargeController.mobileNumberController.text;
                                          mobileRechargeController.ReAmount = mobileRechargeController.mobileAmountController.text;
                                          mobileRechargeController.mobileRechargeApi("");
                                        }
                                      }).paddingOnly(left: MediaQuery.of(context).size.height * 0.1, right: MediaQuery.of(context).size.width * 0.2),
                                  15.height,
                                ],
                              ).paddingAll(10),
                            ).paddingAll(20)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                mobileRechargeController.isLoading.value?  const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()):Container(),
              ],
            );
          }
          )
      ),
    );
  }
}




