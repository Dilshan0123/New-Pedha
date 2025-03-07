import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart' as otpf;
import 'package:otp_text_field/otp_field_style.dart' as otpfs;
import 'package:otp_text_field/style.dart' as otps;

import '../../component/Popup/popUp.dart';

class BBPSPinPage extends StatefulWidget {
  const BBPSPinPage({super.key});

  @override
  State<BBPSPinPage> createState() => _BBPSPinPageState();
}

class _BBPSPinPageState extends State<BBPSPinPage> {

  appController BBPSPinController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
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
          body: Obx(() {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
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
                                  const Text("Reg No. : "),
                                  5.height,
                                  const Text("Name : "),
                                  10.height,
                                  const Text("Total Amount : ")
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(BBPSPinController.RegNumber, style: const TextStyle(fontWeight: FontWeight.bold),),
                                    5.height,
                                    Text(BBPSPinController.billerNumber, style: const TextStyle(fontWeight: FontWeight.bold),),
                                    Text("₹ ${BBPSPinController.bbpsAmount}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
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
                                height: 60,
                                child: otpf.OTPTextField(
                                  obscureText: true,
                                  controller: BBPSPinController.dmtPinController,
                                  length: 6,
                                  width: MediaQuery.of(context).size.width,
                                  fieldWidth: 40,
                                  style: boldTextStyle(size: 24),
                                  // textFieldAlignment: MainAxisAlignment.spaceBetween,
                                  fieldStyle: otps.FieldStyle.box,
                                  otpFieldStyle: otpfs.OtpFieldStyle(
                                    focusBorderColor: color.WAPrimaryColor,
                                    backgroundColor: color.WATextFieldColor,
                                    enabledBorderColor: Colors.transparent,
                                  ),
                                  onChanged: (value) {},
                                  onCompleted: (value) {
                                    BBPSPinController.tpin = value;
                                  },
                                )
                            ),
                          ],
                        ).paddingAll(30),
                        30.height,
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30), color: const Color.fromRGBO(255, 254, 200, 1)
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 90,
                            child: Center(child: Text("Your are transferring money to A/C ${BBPSPinController.RegNumber} - ${BBPSPinController.fieldName}", style: const TextStyle(fontSize: 17),).paddingAll(10))),
                        30.height,
                        AppButton(
                            color: color.WAbtnColor,
                            textColor: Colors.white,
                            shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            width: MediaQuery.of(context).size.width,
                            onTap: BBPSPinController.isLoading.value? null:() {
                              Get.back();
                              if((BBPSPinController.tpin.isNotEmpty && BBPSPinController.tpin !='') && BBPSPinController.tpin.length==6){
                                BBPSPinController.tpin = "";
                              }else {
                                PopUp.toastMessage("Invalid T-Pin !!");
                                BBPSPinController.tpin = "";
                              }
                            },
                            child: BBPSPinController.isLoading.value? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black12,
                                  ),
                                  onPressed: (){}, child: const Text("Loading...")),
                            ) : const Text("Payment ",style: TextStyle(color: Colors.white),)).paddingOnly(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
                      ],
                    ),
                    BBPSPinController.isLoading.value
                        ? const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator())
                        : Container(),
                  ],
                ),
              ),
            );
          }
          ),
        ),
      ),
    );
  }
}
