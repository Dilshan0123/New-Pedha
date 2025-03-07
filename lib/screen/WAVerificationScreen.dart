

import 'package:PedhaPay/screen/WALoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WAVerificationScreen extends StatefulWidget {
  static String tag = '/WAVerificationScreen';

  const WAVerificationScreen({super.key});

  @override
  WAVerificationScreenState createState() => WAVerificationScreenState();
}

class WAVerificationScreenState extends State<WAVerificationScreen>  with TickerProviderStateMixin{

  var verifyController = Get.put(appController());

  TextEditingController mPinController = TextEditingController();


  // bool obscureText = true;

  @override
  void initState() {
    // verifyController.getLoginDetails();
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    verifyController.pinController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
            Hive.box("id").put("is_login",false);
            Get.offAll(const WALoginScreen());
            verifyController.isLoading.value = false;
          }),
        ),
        body: Obx(() {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

                // decoration: BoxDecoration(
                //   image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover),
                // ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      30.height,
                      Image.asset(
                        'assets/otpVerification.png',height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      8.height,
                      Text(
                        verifyController.P_loginDataList.value.shopName??"",
                        style: boldTextStyle(size: 20),
                        textAlign: TextAlign.center,
                      ), 8.height,
                      Text(
                        verifyController.P_loginDataList.value.referId??"",
                        style: boldTextStyle(size: 20),
                        textAlign: TextAlign.center,
                      ),
                      16.height,
                      Text(
                        'Please enter M-Pin below to verify it\'s you',
                        style: secondaryTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      30.height,

                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          obscureText: true,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          enableActiveFill: true,
                          animationType: AnimationType.fade,
                          animationDuration:
                          const Duration(milliseconds: 300),
                          hintCharacter: '',
                          textStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(4),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            inactiveFillColor: Colors.white,
                            inactiveColor: Colors.grey,
                            selectedColor: Colors.grey,
                            activeFillColor: Colors.white,
                            activeColor: Colors.green,
                            selectedFillColor: Colors.white,
                          ),
                          cursorColor: Colors.black,
                          controller: mPinController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onCompleted: (value) {
                            verifyController.finel_pin = value;
                                  if(verifyController.finel_pin.length == 4){
                                    verifyController.verifyMPinApi();
                                  }else{

                                  }
                            mPinController.clear();
                          },
                          onChanged: (value) {
                            //   setState(() {});
                            print(value);
                            if(value.length==4){
                              // verifyMpinApi(value.toString());
                              print(value);
                            }
                          },
                        ),
                      ),
                      16.height,
                      20.height,
                      FadeTransition(
                        opacity: _animation,
                        child: const Padding(padding: EdgeInsets.all(8), child: Text("DTH | MOBILE Recharge | BILL PAYMENTS",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent))),
                      ),
                    ],
                  ).paddingAll(30),
                ),
              ),
              verifyController.isLoading.value?  const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()):Container(),
            ],
          );
        }
        ),
      ),
    );
  }
}
