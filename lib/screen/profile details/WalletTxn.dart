
import 'dart:async';

import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletTxn extends StatefulWidget {
  const WalletTxn({super.key});

  @override
  State<WalletTxn> createState() => _WalletTxnState();
}

class _WalletTxnState extends State<WalletTxn> {
  appController walletTxnController = Get.find();

  bool _isVisible = true;

  @override
  void initState() {
    timer = Timer( const Duration(milliseconds: 10), () {
      walletTxnController.mainLadgerApi("");
    });
    super.initState();
  }

  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        walletTxnController.dateinput.clear();
        walletTxnController.toDateInput.clear();
        walletTxnController.search.clear();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Main Ledger",style: TextStyle(color: Colors.white),),
            // iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
          ),
          body: Obx(() {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: TextField(style: const TextStyle(fontSize: 13),
                                    onChanged: (value) => walletTxnController.runFilter(value),
                                    controller: walletTxnController.dateinput,
                                    //editing controller of this TextField
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      prefixIcon: const Icon(
                                        Icons.calendar_today, size: 20,
                                        color: Colors.black,),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      //  icon: Icon(Icons.calendar_today,size: 30,), //icon of text field
                                      labelText: "From", //label text of field
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101)
                                      );
                                      if (pickedDate != null) {
                                        print(pickedDate);
                                        String formattedDate = DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                        print(formattedDate);
                                        setState(() {
                                          walletTxnController.dateinput.text = formattedDate; //set output date to TextField value.
                                          // runFilter(dateinput.text);
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: TextField(
                                    style: const TextStyle(fontSize: 13),
                                    onChanged: (value) => walletTxnController.runFilter(value),
                                    controller: walletTxnController.toDateInput,
                                    // Editing controller for the "to date" TextField
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      prefixIcon: const Icon(
                                          Icons.calendar_today, size: 20,
                                          color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      labelText: "To", // Label text for the "to date" TextField
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        String formattedDate = DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                        setState(() {
                                          walletTxnController.toDateInput.text =
                                              formattedDate;
                                          // runFilter(toDateInput.text);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              5.width,
                              InkWell(
                                onTap: (){
                                  walletTxnController.mainLadgerDateWiseApi("");
                                },
                                child: Container(
                                    height: 40,
                                    color: Colors.blue,
                                    width: 40,
                                    child: const Icon(Icons.search,color: Colors.white,)
                                ),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                            visible: _isVisible,
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                onChanged: (value)=>walletTxnController.walletSearchFilter(value),
                                controller: walletTxnController.search,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(top: 20),
                                    prefixIcon: const Icon(Icons.search),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    hintText: "Services/TxnId/amount"),

                              ),
                            ),

                          ),
                        ),
                        Row(
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text( "History",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              ),
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.topLeft,
                              child: ElevatedButton(
                                child: Text(_isVisible ? "Hide filter" : "Show filter"),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                              ),
                            ).paddingOnly(right: 10),
                          ],
                        ),
                        Expanded(
                            child: walletTxnController.walletTxn()
                        ),
                      ],
                    ),
                    walletTxnController.isLoading.value?  const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator()):Container(),
                  ],
                ),
              ),
            );
          })
      ),
    );
  }
}
