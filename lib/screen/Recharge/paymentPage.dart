import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart' as otpF;
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class paymentPage extends StatefulWidget {
  const paymentPage({super.key});

  @override
  State<paymentPage> createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {

  appController rechargePaymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:Theme.of(context).primaryColor,
          elevation: 0,
          title: const Text("Pay", style: TextStyle(fontSize: 25),),
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              // backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: const Icon(Icons.arrow_back,color: Colors.black,),
          ).onTap(() {
            finish(context);
          }),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  color: color.WASecondColor,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Mobile Number : "),
                          5.height,
                          const Text("Amount : "),
                          5.height,
                          const Text("Operator : ")
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(rechargePaymentController.MobileNumber),
                            5.height,
                            Text("₹ ${rechargePaymentController.ReAmount}", style: const TextStyle(fontWeight: FontWeight.bold),),
                            5.height,
                            Image.network(rechargePaymentController.providerImage,height: 20,),
                            // Text(rechargePaymentController.providerName, style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )
                    ],
                  ).paddingOnly(left: 20, right: 20, top: 10, bottom: 10),
                ).paddingOnly(top: 50),
                20.height,
                Text(
                  "ENTER 6-DIGIT T-PIN",
                  style: secondaryTextStyle(),
                  textAlign: TextAlign.center,
                ),
                30.height,
                Wrap(
                  children: [
                    SizedBox(
                        height: 40,
                        child: otpF.OTPTextField(
                          obscureText: true,
                          controller: rechargePaymentController.dmtPinController,
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 40,
                          style: boldTextStyle(size: 24),
                          // textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldStyle: FieldStyle.box,
                          otpFieldStyle: OtpFieldStyle(
                            focusBorderColor: color.WAPrimaryColor,
                            backgroundColor: color.WATextFieldColor,
                            enabledBorderColor: Colors.transparent,
                          ),
                          onChanged: (value) {},
                          onCompleted: (value) {
                            rechargePaymentController.tpin = value;
                          },
                        )
                    ),
                  ],
                ).paddingAll(30),
                30.height,
                Visibility(
                  visible: rechargePaymentController.isVisibleRechargeMsg.value,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30), color: const Color.fromRGBO(255, 254, 200, 1)
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 90,
                      child: Center(child: Text("Please enter valid details. Geting this message ${rechargePaymentController.paymentMessage}",style: const TextStyle(fontSize: 17),).paddingAll(10))),
                ),
                30.height,
                AppButton(
                   color: color.WAbtnColor,
                    textColor: Colors.white,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    width: MediaQuery.of(context).size.width,
                    onTap: rechargePaymentController.isLoading.value? null: () {
                      if((rechargePaymentController.tpin.isNotEmpty && rechargePaymentController.tpin !='') && rechargePaymentController.tpin.length==6){
                        rechargePaymentController.isVisibleRechargeMsg.value = false;
                        rechargePaymentController.service = "PREPAID";
                        rechargePaymentController.mobileRechargeApi("rechageproccess");
                        rechargePaymentController.dmtPinController.clear();
                        rechargePaymentController.tpin = "";
                      }else{
                        rechargePaymentController.dmtPinController.clear();
                        PopUp.toastErrorMessage("Invalid Pin !!");
                        rechargePaymentController.tpin = "";
                      }

                    },
                   child: rechargePaymentController.isLoading.value? AppButton(
                text: "Loading...",
                  textColor: Colors.white,
                  color: color.WAbtnColor,
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  width:  MediaQuery.of(context).size.width,
                  onTap: (){},
                ) : const Text('Payment',style: TextStyle(color: Colors.white),)).paddingOnly(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
