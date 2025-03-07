
import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_model/appController.dart';


class BBPSSuccessPage extends StatefulWidget {
  const BBPSSuccessPage({super.key});

  @override
  State<BBPSSuccessPage> createState() => _BBPSSuccessPageState();
}

class _BBPSSuccessPageState extends State<BBPSSuccessPage> {


  bool isPlaying = false;
  // final controller = ConfettiController();
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   controller.play();
  // }
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  appController paymentSlipController = Get.find();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Payment Status",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          // leading: Icon(Icons.payment),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Payment Status Image and Message
                Column(
                  children: [
                    paymentSlipController.paymentStatus == "S"
                        ? Image.asset(
                      "assets/success.gif",
                      height: MediaQuery.of(context).size.height * 0.2,
                    )
                        : paymentSlipController.paymentStatus == "P"
                        ? Icon(
                      Icons.pending,
                      size: MediaQuery.of(context).size.height * 0.2,
                      color: Colors.orange,
                    )
                        : Image.asset(
                      "assets/failed.gif",
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      paymentSlipController.paymentMessage,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: paymentSlipController.paymentStatus == "S"
                            ? Colors.green
                            : paymentSlipController.paymentStatus == "P"
                            ? Colors.orange
                            : Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      paymentSlipController.selectedSubCategoryList.value[0].providerName ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ).paddingAll(16),
                // Provider Information
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      paymentSlipController.buildDetailRow("Name:", paymentSlipController.billFechList.value[0].userName!),
                      paymentSlipController.buildDetailRow("Acc Number:", paymentSlipController.billFechList.value[0].cellNumber!),
                      paymentSlipController.buildDetailRow("Bill Date:", paymentSlipController.billFechList.value[0].billdate!),
                      paymentSlipController.buildDetailRow("Txn ID:", paymentSlipController.txnId),
                      paymentSlipController.buildDetailRow("Status:", paymentSlipController.paymentStatus == "S"
                          ? "Success"
                          : paymentSlipController.paymentStatus == "P"
                          ? "Pending"
                          : "Failed",
                        valueStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: paymentSlipController.paymentStatus == "S"
                              ? Colors.green
                              : paymentSlipController.paymentStatus == "P"
                              ? Colors.orange
                              : Colors.red,
                        ),),
                      paymentSlipController.buildDetailRow("Amount:", "₹ ${paymentSlipController.bbpsAmount}"),
                      const SizedBox(height: 10),
                    ],
                  ).paddingOnly(left: 15,right: 15),
                ),
                // Bottom Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.home),
                      label: const Text("Home"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        PopUp.toastErrorMessage("Coming soon !!");
                        // Add print logic here
                      },
                      icon: const Icon(Icons.print),
                      label: const Text("Print"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "* This is a system-generated receipt and does not require a signature.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

