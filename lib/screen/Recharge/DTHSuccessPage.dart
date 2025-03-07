import 'package:PedhaPay/screen/WADashboardScreen.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class RechargeSuccessPage extends StatefulWidget {
  const RechargeSuccessPage({super.key});

  @override
  State<RechargeSuccessPage> createState() => _RechargeSuccessPageState();
}

class _RechargeSuccessPageState extends State<RechargeSuccessPage> {


  appController succesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.back();
        Get.back();
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                      onTap: (){
                        Get.back();
                        Get.back();
                      },
                      child: const Icon(Icons.dangerous_outlined,size: 30,))),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Expanded(child: succesController.paymentStatusShow(),),
              Text("${succesController.currentDate} ${succesController.currentTime}"),
              const SizedBox(height: 20),
              succesController.rechargeDsc(),
              const SizedBox(height: 30),
              Card(
                child: ListTile(
                  // leading: Image.network(succesController.providerImage),
                  title: Text(succesController.providerName,style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(succesController.MobileNumber),
                  trailing: Text('₹ ${succesController.ReAmount}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              AppButton(
                text: "Home",
                color: color.WAbtnColor,
                textColor: Colors.white,
                shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width,
                onTap: () {
                  Get.to(const WADashboardScreen());
                  // Get.back();
                },
              ).paddingOnly(left: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.width * 0.01),
            ],
          ),
        ).paddingOnly(top: MediaQuery.of(context).size.height * 0.06, left: 10, right: 10),
      ),
    );
  }
}



