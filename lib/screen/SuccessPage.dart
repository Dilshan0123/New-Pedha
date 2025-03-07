import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class DMTSuccessPage extends StatefulWidget {
  const DMTSuccessPage({super.key});

  @override
  State<DMTSuccessPage> createState() => _DMTSuccessPageState();
}

class _DMTSuccessPageState extends State<DMTSuccessPage> {


  bool isPlaying = false;

  appController paymentSlipController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.back();
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE0F7FA), // Light cyan background color
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(paymentSlipController.paymentMessage),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    if(paymentSlipController.service == "DMT 1") ...[
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(child: paymentSlipController.paymentStatusShow()),
                            Text(paymentSlipController.currentDate,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                            const SizedBox(height: 10),
                            Text(
                              'Txn Amount: Rs. ${paymentSlipController.dmtAmount}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text("Txn Id : ${paymentSlipController.dmtTxnId}",style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,),
                            Text(paymentSlipController.beneAccountNumber,style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,),

                            const SizedBox(height: 10),

                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: const Align(
                                                alignment: Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.blue,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Txn Id :",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.dmtTxnId,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Name",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.selectedBeneList[0].name!,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Account",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.selectedBeneList[0].account!,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Message:",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.paymentMessage ?? "N/A",
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Status:",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.paymentStatus == "S"
                                                              ? 'Success'
                                                              : paymentSlipController.paymentStatus == "P"
                                                              ? 'Pending'
                                                              : 'Failed',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            color: paymentSlipController.paymentStatus == "S"
                                                                ? Colors.green
                                                                : paymentSlipController.paymentStatus == "P"
                                                                ? Colors.orange
                                                                : Colors.red,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Amount:",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "₹ ${paymentSlipController.dmtAmount}",
                                                          style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

                              },
                              child: const Text(
                                'View Transaction Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ).paddingAll(10),
                      ),
                    ] else if(paymentSlipController.service == "DMT 2") ...[
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(child: paymentSlipController.paymentStatusShow()),
                            Text(paymentSlipController.currentDate,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                            const SizedBox(height: 10),
                            Text(
                              'Txn Amount: Rs. ${paymentSlipController.dmtAmount}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text("Txn Id : ${paymentSlipController.dmtTxnId}",style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,),
                            Text(paymentSlipController.beneAccountNumber,style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,),

                            const SizedBox(height: 10),

                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: const Align(
                                                alignment: Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.blue,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Txn Id :",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.dmtTxnId,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Name",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.beneListBack[0].name!,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Account",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.beneListBack[0].account!,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Message:",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.paymentMessage ?? "N/A",
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Status:",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          paymentSlipController.paymentStatus == "S"
                                                              ? 'Success'
                                                              : paymentSlipController.paymentStatus == "P"
                                                              ? 'Pending'
                                                              : 'Failed',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            color: paymentSlipController.paymentStatus == "S"
                                                                ? Colors.green
                                                                : paymentSlipController.paymentStatus == "P"
                                                                ? Colors.orange
                                                                : Colors.red,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Amount:",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "₹ ${paymentSlipController.dmtAmount}",
                                                          style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

                              },
                              child: const Text(
                                'View Transaction Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ).paddingAll(10),
                      ),
                    ]else if(paymentSlipController.service == "OnlineBBPS") ...[
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(child: paymentSlipController.paymentStatusShow()),
                            Text(paymentSlipController.currentDate,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                            const SizedBox(height: 10),
                            Text(
                              'Txn Amount: Rs. ${paymentSlipController.bilfetchListData.value[0].billAmount!}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(paymentSlipController.bilfetchListData.value[0].userName!,style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,),
                            Text(paymentSlipController.bbpsfirstField,style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,),
                            Text("Txn Id : ${paymentSlipController.dmtTxnId}",style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,),

                            const SizedBox(height: 10),

                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: const Align(
                                                alignment: Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.blue,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if(paymentSlipController.service == "DMT") ...[
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: paymentSlipController.viewDmtPaymentList.value.length,
                                                itemBuilder: (context, index) {
                                                  var payment = paymentSlipController.viewDmtPaymentList.value[index];
                                                  return Card(
                                                    elevation: 5,
                                                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Ref Id:",
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  payment.txnId!,
                                                                  style: const TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(),
                                                          const SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Name",
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  payment.beneName!,
                                                                  style: const TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(),
                                                          const SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Message:",
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  payment.responseMessage ?? "N/A",
                                                                  style: const TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(),
                                                          const SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Status:",
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  payment.status == "S"
                                                                      ? 'Success'
                                                                      : payment.status == "P"
                                                                      ? 'Pending'
                                                                      : 'Failed',
                                                                  style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: payment.status == "S"
                                                                        ? Colors.green
                                                                        : payment.status == "P"
                                                                        ? Colors.orange
                                                                        : Colors.red,
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(),
                                                          const SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Amount:",
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "₹ ${payment.amount}",
                                                                  style: const TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ] else if(paymentSlipController.service == "BBPS") ...[

                                              Column(
                                                children: [
                                                  10.height,
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: const Color(0xFFC4BBC2)
                                                      ),
                                                      child: Text(
                                                        paymentSlipController.providerName,
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(fontWeight: FontWeight.bold,
                                                          fontSize: 20,),).paddingAll(5),),
                                                  ),
                                                  20.height,
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                              width: MediaQuery.of(context).size.width *
                                                                  0.25,
                                                              child: const Text(
                                                                "Name :",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)),
                                                          Expanded(
                                                              child: Text(
                                                                paymentSlipController.off_BillFetchListData.value[0].customerName!,
                                                                style: const TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)),
                                                        ],
                                                      ),
                                                      const Divider(
                                                        color: Colors.grey,
                                                        thickness: 1,
                                                      ),
                                                      10.height,
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                              width: MediaQuery.of(context).size.width *
                                                                  0.25,
                                                              child: const Text(
                                                                "Acc No. :",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)
                                                          ),
                                                          Expanded(
                                                              child: Text(
                                                                paymentSlipController.bbpsfirstField,
                                                                style: const TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)
                                                          ),
                                                        ],
                                                      ),
                                                      10.height,
                                                      const Divider(
                                                        color: Colors.grey,
                                                        thickness: 1,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                              width: MediaQuery.of(context).size.width *
                                                                  0.25,
                                                              child: const Text(
                                                                "Bill Date :",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)),
                                                          Expanded(
                                                              child: Text(paymentSlipController.currentDate ?? 'No date available',
                                                                style: const TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)),
                                                        ],
                                                      ),
                                                      10.height,
                                                      const Divider(
                                                        color: Colors.grey,
                                                        thickness: 1,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                              width: MediaQuery.of(context).size.width *
                                                                  0.25,
                                                              child: const Text(
                                                                "Status :",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)),
                                                          Expanded(
                                                              child: Text(
                                                                paymentSlipController.paymentStatus == "S"? "Success": "Failed",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold,color: paymentSlipController.paymentStatus == "S"? Colors.green : Colors.red),
                                                              ).paddingOnly(left: 10)),
                                                        ],
                                                      ), 10.height,
                                                      const Divider(
                                                        color: Colors.grey,
                                                        thickness: 1,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                              width: MediaQuery.of(context).size.width *
                                                                  0.25,
                                                              child: const Text(
                                                                "Amount :",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)),
                                                          Expanded(
                                                              child: Text(
                                                                "₹ ${paymentSlipController.off_BillFetchListData.value[0].billamount!}",
                                                                style: const TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold),
                                                              ).paddingOnly(left: 10)),
                                                        ],
                                                      ),
                                                      10.height,
                                                      const Divider(
                                                        color: Colors.grey,
                                                        thickness: 1,
                                                      ),
                                                    ],
                                                  ),
                                                  30.height,
                                                ],
                                              ),
                                            ]

                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

                              },
                              child: const Text(
                                'View Transaction Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ).paddingAll(10),
                      ),
                    ]else if(paymentSlipController.service == "d2d")...[
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(child: paymentSlipController.paymentStatusShow()),
                            Text(paymentSlipController.currentDate,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                            const SizedBox(height: 10),
                            Text('Txn Amount: Rs. ${paymentSlipController.dmtAmount}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                            const SizedBox(height: 10),
                            Text(paymentSlipController.benName,style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center),

                            const SizedBox(height: 10),

                          ],
                        ).paddingAll(10),
                      ),
                    ]else if(paymentSlipController.service == "AEPS_FingPay") ...[
                      // Container(
                      //   color: Colors.white,
                      //   height: MediaQuery.of(context).size.height * 0.45,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Column(
                      //     children: [
                      //       Expanded(child: paymentSlipController.paymentStatusShow()),
                      //       Text("${paymentSlipController.currentDate} ,${paymentSlipController.currentTime}" ,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      //         textAlign: TextAlign.center,),
                      //       const SizedBox(height: 10),
                      //       Text(
                      //         'Txn Amount: Rs. ${paymentSlipController.aepsAmount}',
                      //         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      //         textAlign: TextAlign.center,
                      //       ),
                      //       const SizedBox(height: 10),
                      //       Text(paymentSlipController.txnId,style: const TextStyle(fontSize: 16),
                      //         textAlign: TextAlign.center,),
                      //       Text("Bank RRN - ${paymentSlipController.BankRNN}",style: const TextStyle(fontSize: 16),
                      //         textAlign: TextAlign.center,),
                      //
                      //       const SizedBox(height: 10),
                      //
                      //     ],
                      //   ).paddingAll(10),
                      // ),
                    ],

                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      if(paymentSlipController.service != "d2d")...[
                        ElevatedButton.icon(
                          icon: const Icon(Icons.print),
                          label: const Text('PRINT'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.white, minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {

                            if(paymentSlipController.service == "DMT"){
                              // paymentSlipController.viewInvoice();
                            }else{
                              PopUp.toastMessage("Processing now !!");
                            }
                          },
                        ),
                      ],

                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.cyan, minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Handle close action
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('CLOSE'),
                      ),
                    ],
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
