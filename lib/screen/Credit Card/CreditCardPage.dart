import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/Popup/popUp.dart';
import '../../utils/WAColors.dart';
import '../../utils/WAWidgets.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {

  appController creditCardController = Get.find();

  final _formKey = GlobalKey<FormState>();
  final creNumber = GlobalKey<FormState>();
  final creName = GlobalKey<FormState>();
  final creAmount = GlobalKey<FormState>();
  final pinKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        creditCardController.tpin  = "";
        creditCardController.tPinPaymentCOntroller.clear();
        creditCardController.amountController.clear();
        creditCardController.custmerNameController.clear();
        creditCardController.fieldNumberController.clear();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Credit Card Payment",style: TextStyle(color: Colors.white),),
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Obx(() {
            return Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(16),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                  decoration: boxDecorationWithShadow(borderRadius: BorderRadius.circular(30)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset("assets/CreditCardBannar.jpeg").center(),
                                          10.height,
                                          Text("Credit Card Number", style: boldTextStyle(size: 14)),
                                          8.height,
                                          Form(
                                            key: creNumber,
                                            child: AppTextField(
                                              maxLength: 20,
                                              textCapitalization: TextCapitalization.characters,
                                              onChanged: (value){
                                                creNumber.currentState!.validate();
                                              },
                                              validator: Validation.validationRequired,
                                              decoration: waInputDecoration(hint: 'Credit card number ', prefixIcon: Icons.lock_outline),
                                              suffixIconColor: color.WAPrimaryColor,
                                              textFieldType: TextFieldType.PHONE,
                                              controller: creditCardController.fieldNumberController,

                                            ),
                                          ),
                                          20.height,
                                          Text("Card Holder Name", style: boldTextStyle(size: 14)),
                                          8.height,
                                          Form(
                                            key: creName,
                                            child: AppTextField(
                                              maxLength: 20,
                                              textCapitalization: TextCapitalization.characters,
                                              onChanged: (value){
                                                creName.currentState!.validate();
                                              },
                                              validator: Validation.validationRequired,
                                              decoration: waInputDecoration(hint: 'Card Holder Name', prefixIcon: Icons.lock_outline),
                                              suffixIconColor: color.WAPrimaryColor,
                                              textFieldType: TextFieldType.NAME,
                                              controller: creditCardController.custmerNameController,

                                            ),
                                          ),
                                          10.height,
                                          Text("Amount", style: boldTextStyle(size: 14)),
                                          8.height,
                                          Form(
                                            key: creAmount,
                                            child: AppTextField(
                                                maxLength: 7,
                                                // validator: Validation.validateAmount,
                                                onChanged: (value){
                                                  creAmount.currentState!.validate();
                                                },
                                                decoration: waInputDecoration(hint: 'Amount', prefixIcon: Icons.person),
                                                // suffixIconColor: color.WAPrimaryColor,
                                                textFieldType: TextFieldType.PHONE,
                                                isPassword: true,
                                                controller: creditCardController.amountController
                                              // focus: confirmPassWordFocusNode,
                                            ),
                                          ),
                                          10.height,
                                          Text("T-Pin", style: boldTextStyle(size: 14)),
                                          8.height,
                                          Form(
                                            key: pinKey,
                                            child: AppTextField(
                                              maxLength: 6,
                                              textCapitalization: TextCapitalization.characters,
                                              onChanged: (value){
                                                // pinKey.currentState!.validate();
                                                setState(() {
                                                  if(value.length == 6){
                                                    creditCardController.tpin = creditCardController.tPinPaymentCOntroller.text;
                                                    print("Tpin ${creditCardController.tpin}");
                                                  }
                                                });
                                              },
                                              validator: Validation.validationRequired,
                                              decoration: waInputDecoration(hint: 'Enter T-Pin ', prefixIcon: Icons.pin),
                                              suffixIconColor: color.WAPrimaryColor,
                                              controller: creditCardController.tPinPaymentCOntroller,
                                              textFieldType: TextFieldType.PASSWORD,
                                              obscureText: true,
                                              keyboardType: TextInputType.phone,
                                            ),
                                          ),
                                          10.height,
                                          AppButton(
                                              color: color.WAbtnColor,
                                              textColor: Colors.white,
                                              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                              width: MediaQuery.of(context).size.width,
                                              onTap: creditCardController.isLoading.value? null: () {
                                                if(creNumber.currentState!.validate()
                                                    && creName.currentState!.validate()
                                                    && creAmount.currentState!.validate()
                                                    && pinKey.currentState!.validate()){
                                                  if((creditCardController.tpin.isNotEmpty && creditCardController.tpin !='') && creditCardController.tpin.length==6){
                                                    creditCardController.BeneFiName = creditCardController.custmerNameController.text;
                                                    creditCardController.beneAccountNumber = creditCardController.fieldNumberController.text;
                                                    creditCardController.dmtAmount = creditCardController.amountController.text;
                                                    creditCardController.creditCardDetails();
                                                  }else{
                                                    PopUp.toastMessage("Invalid T-Pin !!");
                                                  }
                                                }

                                              },
                                              child: creditCardController.isLoading.value? AppButton(
                                                text: "Loading...",
                                                textColor: Colors.white,
                                                color: color.WAbtnColor,
                                                shapeBorder: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                width: MediaQuery.of(context).size.width,
                                                onTap: () {
                                                  creditCardController.isLoading.value = false;
                                                },
                                              ) : const Text("Payment ",style: TextStyle(color: Colors.white),)
                                          ).paddingOnly(left: MediaQuery.of(context).size.height * 0.05, right: MediaQuery.of(context).size.width * 0.15),
                                          15.height,
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                creditCardController.isLoading.value?  const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()):Container(),
              ],
            );
          },
          )),
    );
  }
}
