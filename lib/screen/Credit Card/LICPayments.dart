

import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/utils/WAWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../view_model/appController.dart';


class LICPayment extends StatefulWidget {
  const LICPayment({super.key});

  @override
  State<LICPayment> createState() => _LICPaymentState();
}

class _LICPaymentState extends State<LICPayment> {

  appController LICController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }

  final _formKey = GlobalKey<FormState>();
  final creNumber = GlobalKey<FormState>();
  final creName = GlobalKey<FormState>();
  final creAmount = GlobalKey<FormState>();
  final dobKey = GlobalKey<FormState>();
  final pinKey = GlobalKey<FormState>();

  void _refreshPage() {
    // Clear the controllers or reload necessary data
    LICController.fieldNumberController.clear();
    LICController.custmerNameController.clear();
    LICController.dateOfBirthController.clear();
    LICController.isVisiblePlanBtn.value = false; // Reset visibility if needed
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        LICController.tPinPaymentCOntroller.clear();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("LIC Payment",style: TextStyle(color: Colors.white),),
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
                                          Image.asset("assets/lic.jpeg").center(),
                                          20.height,
                                          Text("Costumer Id", style: boldTextStyle(size: 14)),
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
                                              decoration: waInputDecoration(hint: 'Enter Costumer Id ', prefixIcon: Icons.supervised_user_circle),
                                              suffixIconColor: color.WAPrimaryColor,
                                              textFieldType: TextFieldType.PHONE,
                                              controller: LICController.fieldNumberController,

                                            ),
                                          ),
                                          20.height,
                                          Text("E-mail", style: boldTextStyle(size: 14)),
                                          8.height,
                                          Form(
                                            key: creName,
                                            child: AppTextField(
                                              maxLength: 50,
                                              onChanged: (value){
                                                creName.currentState!.validate();
                                              },
                                              validator: Validation.validationRequired,
                                              decoration: waInputDecoration(hint: 'Enter E-mail', prefixIcon: Icons.mail),
                                              suffixIconColor: color.WAPrimaryColor,
                                              textFieldType: TextFieldType.EMAIL,
                                              controller: LICController.custmerNameController,

                                            ),
                                          ),
                                          10.height,
                                          Text("Date of Birth", style: boldTextStyle(size: 14)),
                                          8.height,
                                          Form(
                                            key: dobKey,
                                            child: AppTextField(
                                              validator: Validation.validationRequired,
                                              decoration: waInputDecoration(hint: 'Select Date', prefixIcon: Icons.calendar_today),
                                              controller: LICController.dateOfBirthController, // Controller for date text
                                              onTap: () async {
                                                FocusScope.of(context).requestFocus(FocusNode()); // Dismiss keyboard
                                                DateTime? selectedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950), // Earliest selectable date
                                                  lastDate: DateTime(2100), // Latest selectable date
                                                );

                                                if (selectedDate != null) {
                                                  String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
                                                  LICController.dateOfBirthController.text = formattedDate; // Format date
                                                }
                                              },
                                              readOnly: true, // Prevent manual editing
                                              textFieldType: TextFieldType.NAME,
                                            ),
                                          ),
                                          // 10.height,
                                          // Text("T-Pin", style: boldTextStyle(size: 14)),
                                          // 8.height,
                                          // Form(
                                          //   key: pinKey,
                                          //   child: AppTextField(
                                          //     maxLength: 6,
                                          //     textCapitalization: TextCapitalization.characters,
                                          //     onChanged: (value){
                                          //       // pinKey.currentState!.validate();
                                          //       setState(() {
                                          //         if(value.length == 6){
                                          //           LICController.tpin = LICController.tPinPaymentCOntroller.text;
                                          //           print("Tpin "+LICController.tpin);
                                          //         }
                                          //       });
                                          //     },
                                          //     validator: Validation.validationRequired,
                                          //     decoration: waInputDecoration(hint: 'Enter T-Pin ', prefixIcon: Icons.pin),
                                          //     suffixIconColor: color.WAPrimaryColor,
                                          //     controller: LICController.tPinPaymentCOntroller,
                                          //     textFieldType: TextFieldType.PASSWORD,
                                          //     obscureText: true,
                                          //     keyboardType: TextInputType.phone,
                                          //   ),
                                          // ),
                                          10.height,
                                          AppButton(
                                              color: color.WAbtnColor,
                                              textColor: Colors.white,
                                              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                              width: MediaQuery.of(context).size.width,
                                              onTap: LICController.isLoading.value? null: () {
                                                if(creNumber.currentState!.validate()
                                                    && creName.currentState!.validate()
                                                    && dobKey.currentState!.validate()
                                                ){
                                                  LICController.licBillFetchDetails();
                                                }
                                              },
                                              child: LICController.isLoading.value? AppButton(
                                                text: "Loading...",
                                                textColor: Colors.white,
                                                color: color.WAbtnColor,
                                                shapeBorder: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                width: MediaQuery.of(context).size.width,
                                                onTap: () {
                                                  LICController.isLoading.value = false;
                                                },
                                              ) : const Text("Bill Fetch ",style: TextStyle(color: Colors.white),)
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
                LICController.isLoading.value?  const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()):Container(),
              ],
            );
          },
          )),
    );
  }
}
