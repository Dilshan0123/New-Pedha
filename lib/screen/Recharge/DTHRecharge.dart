
import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/model/Pedha%20Pay%20Model/Recharge/PlanModel.dart';
import 'package:PedhaPay/screen/Recharge/getDTHPlane.dart';
import 'package:PedhaPay/screen/Recharge/mobileRechargePlan.dart';
import 'package:PedhaPay/screen/Recharge/paymentPage.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../model/Pedha Pay Model/Recharge/ReOperatorModel.dart';
import '../../utils/WAWidgets.dart';
import 'Provider.dart';



class DTHRecharge extends StatefulWidget {
  const DTHRecharge({super.key});

  @override
  State<DTHRecharge> createState() => _DTHRechargeState();
}

class _DTHRechargeState extends State<DTHRecharge> {

  appController dthRechargeController = Get.find();

  @override
  void initState() {
    dthRechargeController.getDTHOperatorApi();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }


  void _refreshPage() {
    // Clear the controllers or reload necessary data
    dthRechargeController.mobileNumberController.clear();
    dthRechargeController.mobileOperatorController.clear();
    dthRechargeController.mobileAmountController.clear();
    dthRechargeController.isVisiblePlanBtn.value = false; // Reset visibility if needed
  }


  FocusNode OperatorFocus = FocusNode();
  FocusNode AmountFocus = FocusNode();
  FocusNode btnFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final dthNumberKey = GlobalKey<FormState>();
  final dthOperatorKey = GlobalKey<FormState>();
  final dthAmountKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        // dthRechargeController.mobileNumberController.clear();
        // dthRechargeController.mobileOperatorController.clear();
        // dthRechargeController.mobileAmountController.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "DTH Recharge",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          color: color.BackGroundColor3,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.6,
                        ).paddingOnly(top: 80),
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
                              Text("Consumer Number", style: boldTextStyle(size: 14)),
                              8.height,
                              Form(
                                key: dthNumberKey,
                                child: AppTextField(
                                  onChanged: (value) {
                                    dthNumberKey.currentState!.validate();
                                  },
                                  maxLength: 12,
                                  validator: Validation.validationRequired,
                                  decoration: waInputDecoration(
                                      hint: 'DTH / Mobile Number', prefixIcon: Icons.account_box),
                                  textFieldType: TextFieldType.PHONE,
                                  keyboardType: TextInputType.number,
                                  controller: dthRechargeController.mobileNumberController,
                                ),
                              ),
                              16.height,
                              Text("Operator", style: boldTextStyle(size: 14)),
                              8.height,
                              Form(
                                key: dthOperatorKey,
                                child: AppTextField(
                                  validator: Validation.validationRequired,
                                  focus: OperatorFocus,
                                  decoration: waInputDecoration(
                                    hint: 'Operator',
                                    prefixIcon: Icons.tv,
                                  ),
                                  textFieldType: TextFieldType.EMAIL,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: dthRechargeController.mobileOperatorController,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(AmountFocus);
                                  },
                                  onTap: () async {
                                    AmountFocus.requestFocus();
                                    RechargeOperatorDataModel result =
                                    await Get.to(const DTHProvider());
                                    debugPrint(result.providerName);
                                    dthRechargeController.isVisiblePlanBtn.value = true;
                                    dthRechargeController.operator =
                                        result.providerAlias!.toString();
                                    dthRechargeController.mobileOperatorController.text =
                                        result.providerName.toString();
                                    dthRechargeController.providerName =
                                        result.providerName.toString();
                                    List<String> parts = result.providerAlias!.split("|");
                                    dthRechargeController.operator = parts[0];
                                                                    },
                                ),
                              ),
                              16.height,
                              Text("Amount", style: boldTextStyle(size: 14)),
                              8.height,
                              Form(
                                key: dthAmountKey,
                                child: AppTextField(
                                  onChanged: (value) {
                                    dthAmountKey.currentState!.validate();
                                  },
                                  maxLength: 4,
                                  validator: Validation.validateRchargeAmount,
                                  focus: AmountFocus,
                                  decoration: waInputDecoration(
                                      hint: 'amount ', prefixIcon: Icons.currency_rupee),
                                  suffixIconColor: color.WAPrimaryColor,
                                  textFieldType: TextFieldType.PHONE,
                                  controller: dthRechargeController.mobileAmountController,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(btnFocus);
                                  },
                                ),
                              ),
                              5.height,
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () async {
                                    if (dthNumberKey.currentState!.validate() &&
                                        dthOperatorKey.currentState!.validate()) {
                                      PopUp.toastErrorMessage("Internal Server Error !!");
                                      // dthRechargeController.MobileNumber =
                                      //     dthRechargeController.mobileNumberController.text;
                                      // Records result = await Get.to( DTHPlansScreen());
                                      // dthRechargeController.operator = result.toString();
                                      // dthRechargeController.mobileAmountController.text =
                                      //     result.rs.toString();
                                      // FocusScope.of(context).requestFocus(btnFocus);
                                                                        }
                                  },
                                  child: const Text(
                                    "View Plan",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ).paddingOnly(right: 5),
                              ),
                              16.height,
                              AppButton(
                                text: "Submit",
                                color: color.WAbtnColor,
                                textColor: Colors.white,
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                width: MediaQuery.of(context).size.width,
                                onTap: () {
                                  if (dthNumberKey.currentState!.validate() &&
                                      dthOperatorKey.currentState!.validate() &&
                                      dthAmountKey.currentState!.validate()) {
                                    dthRechargeController.MobileNumber =
                                        dthRechargeController.mobileNumberController.text;
                                    dthRechargeController.ReAmount =
                                        dthRechargeController.mobileAmountController.text;
                                    dthRechargeController.service = "DTH";
                                    Get.to(const paymentPage());
                                  }
                                },
                              ).paddingOnly(
                                left: MediaQuery.of(context).size.height * 0.1,
                                right: MediaQuery.of(context).size.width * 0.2,
                              ),
                              15.height,
                            ],
                          ).paddingAll(10),
                        ).paddingAll(20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class DTHProviderDataModel {
  String? status;
  String? message;
  List<ProviderData>? data;

  DTHProviderDataModel({this.status, this.message, this.data});

  DTHProviderDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProviderData>[];
      json['data'].forEach((v) {
        data!.add(ProviderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<DTHProviderDataModel> parseList(dynamic json) {
    if (json.toString().isNotEmpty) {
      return json
          .map<DTHProviderDataModel>(
              (tagJson) => DTHProviderDataModel.fromJson(tagJson))
          .toList();
    } else {
      return <DTHProviderDataModel>[];
    }
  }
}

class ProviderData {
  String? opCode;
  String? opName;
  String? serviceId;
  String? logo;

  ProviderData({this.opCode, this.opName, this.serviceId});

  ProviderData.fromJson(Map<String, dynamic> json) {
    opCode = json['opCode'];
    opName = json['opName'];
    serviceId = json['serviceId'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['opCode'] = opCode;
    data['opName'] = opName;
    data['serviceId'] = serviceId;
    data['logo'] = logo;
    return data;
  }

  // static List<ProviderData> parseList(dynamic json) {
  //   if (json.toString().isNotEmpty) {
  //     return json
  //         .map<ProviderData>(
  //             (tagJson) => ProviderData.fromJson(tagJson))
  //         .toList();
  //   } else {
  //     return <ProviderData>[];
  //   }
  // }
}