import 'dart:async';

import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ViewRequestPage extends StatefulWidget {
  const ViewRequestPage({super.key});

  @override
  State<ViewRequestPage> createState() => _ViewRequestPageState();
}

class _ViewRequestPageState extends State<ViewRequestPage> {

  appController viewLoadRequestController = Get.find();
  final bool _isVisible = false;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 50), () {
      // SOMETHING
      viewLoadRequestController.viewLoadRequestApi();
    });

    super.initState();
  }

  String FromdateR = "";
  String TodateR = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        viewLoadRequestController.search.clear();
        viewLoadRequestController.dateinput.clear();
        viewLoadRequestController.toDateInput.clear();
        viewLoadRequestController.txnListData.value.clear();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("${viewLoadRequestController.LagerName} Report",style: const TextStyle(color: Colors.white),),
            backgroundColor: Theme.of(context).primaryColor,
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
                          child: Visibility(
                            // visible: _isVisible,
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                // onChanged: (value)=>viewLoadRequestController.viewLoadFilter(value),
                                controller: viewLoadRequestController.search,
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
                        Expanded(child: viewLoadRequestController.viewLoadList(),)
                      ],
                    ),
                    viewLoadRequestController.isLoading.value?  const Align(
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
