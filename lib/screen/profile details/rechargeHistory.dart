import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../view_model/appController.dart';


class RechargeHistory extends StatefulWidget {
  const RechargeHistory({super.key});

  @override
  State<RechargeHistory> createState() => _RechargeHistoryState();
}

class _RechargeHistoryState extends State<RechargeHistory> {

  late Timer _timer;


  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 50), () {
      // SOMETHING
      rechargeTxnController.serviceHistory("");
    });
    super.initState();
  }

  appController rechargeTxnController = Get.find();

  bool _isVisible = true;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        rechargeTxnController.search.clear();
        rechargeTxnController.dateinput.clear();
        rechargeTxnController.toDateInput.clear();
        rechargeTxnController.txnListData.value.clear();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("${rechargeTxnController.LagerName} History",style: TextStyle(color: Colors.white),),
            iconTheme: const IconThemeData(color: Colors.white),
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
                                    onChanged: (value) => rechargeTxnController.runFilter(value),
                                    controller: rechargeTxnController.dateinput,
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
                                          rechargeTxnController.dateinput.text = formattedDate; //set output date to TextField value.
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
                                    onChanged: (value) => rechargeTxnController.runFilter(value),
                                    controller: rechargeTxnController.toDateInput,
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
                                          rechargeTxnController.toDateInput.text =
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
                                  rechargeTxnController.servicesHistoryDateApi("");
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
                                onChanged: (value)=>rechargeTxnController.searchServicesFilter(value),
                                controller: rechargeTxnController.search,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(top: 20),
                                    prefixIcon: const Icon(Icons.search),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    hintText: "Search"),

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
                            child: rechargeTxnController.TxnHistory()
                        ),
                      ],
                    ),
                    rechargeTxnController.isLoading.value?  const Align(
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
