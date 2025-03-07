import 'dart:async';

import 'package:PedhaPay/view_model/appController.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../model/Pedha Pay Model/Bill Payments/BillPaymetsDataModel.dart';
import '../../utils/WAWidgets.dart';

// 02538278899  : D2H

class BBPSElectricity extends StatefulWidget {
  const BBPSElectricity({super.key});

  @override
  State<BBPSElectricity> createState() => _BBPSElectricityState();
}

class _BBPSElectricityState extends State<BBPSElectricity> {
  appController electryCityController = Get.find();
  late Timer _timer;

  @override
  void initState() {
    if(electryCityController.bbpsService == "offline"){
      _timer = Timer(const Duration(milliseconds: 50), () {
        electryCityController.getOffSubCatApi();
      });
    }else {
      _timer = Timer(const Duration(milliseconds: 50), () {
        electryCityController.getOffSubCatApi();
      });
    }

    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _mobileaKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _dobKey = GlobalKey<FormState>();

  FocusNode nextNode = FocusNode();

  showAmountDetails() {
    if (electryCityController.billStatus == "false") {
      return Visibility(
        visible: electryCityController.isVisibleFalseMessage.value,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromRGBO(255, 254, 200, 1)),
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              children: [
                Center(
                    child: Text(
                  electryCityController.FalseMessage.isNotEmpty?"${electryCityController.FalseMessage}!!":"No details found !!",
                  style: const TextStyle(fontSize: 17),
                ).paddingAll(10)),
              ],
            )).paddingAll(10),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(electryCityController.providerAlias,style: const TextStyle(color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: WillPopScope(
          onWillPop: () async {
            electryCityController.isVisibleOffParam.value = false;
            electryCityController.isVisibleParam.value = false;
            electryCityController.isVisiblePaymentBtn.value = false;
            electryCityController.isVisibleFNumber.value = false;
            electryCityController.fieldNameController.clear();
            electryCityController.dateOfBirthController.clear();
            electryCityController.mobileNumberController.clear();
            electryCityController.bbpsAmountController.clear();
            electryCityController.custmerNameController.clear();
            electryCityController.emailController.clear();
            electryCityController.isVisibleFalseMessage.value = false;
            Get.back();
            return true;
          },
          child: Obx(() {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Category", style: boldTextStyle(size: 14)),
                      8.height,
                      Column(
                        children: [
                          InputDecorator(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: color.WATextFieldColor,
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            ),
                            child: Autocomplete<subCategoryDataModel>(
                              displayStringForOption: (data) => data.providerName!,
                              optionsBuilder: (textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return electryCityController.getSubCategoryList;
                                } else {
                                  return electryCityController.getSubCategoryList
                                      .where((subCategoryDataModel option) {
                                    return option.providerName!
                                        .toLowerCase()
                                        .contains(textEditingValue.text.toLowerCase());
                                  });
                                }
                              },
                              onSelected: (subCategoryDataModel c) {
                                electryCityController.selectedSubCategoryList.value.clear();
                                electryCityController.selectedSubCategoryList.value.add(c);
                                print(electryCityController.selectedSubCategoryList.value[0].providerName);
                                electryCityController.isVisibleOffParam.value = true;
                                FocusScope.of(context).requestFocus(nextNode);
                                electryCityController.fieldNameController.clear();
                                electryCityController.fieldNumberController.clear();
                              },
                              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                                return TextFormField(
                                  validator: Validation.validationRequired,
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: "Select Category",
                                    labelText: "Select Category",
                                    suffixIcon: controller.text.isNotEmpty
                                        ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        controller.clear();
                                        electryCityController.isVisibleFalseMessage.value = false;
                                      },
                                    )
                                        : null,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              },
                              optionsViewBuilder: (context, onSelected, options) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Material(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width - 30,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(top: 1, right: 8),
                                        itemCount: options.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          final subCategoryDataModel option = options.elementAt(index);
                                          return GestureDetector(
                                            onTap: () {
                                              onSelected(option);
                                            },
                                            child: Card(
                                              child: ListTile(
                                                leading: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                  child: option.providerImage!.endsWith(".jpeg") || option.providerImage!.endsWith(".png")
                                                      ? Image.network(
                                                    option.providerImage!,
                                                    fit: BoxFit.cover,
                                                  )
                                                      : SvgPicture.network(
                                                    option.providerImage!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      option.providerName!,
                                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Visibility(
                            visible: electryCityController.isVisibleOffParam.value &&
                                electryCityController.selectedSubCategoryList.isNotEmpty,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.height,
                                  if(electryCityController.selectedSubCategoryList.isNotEmpty) ...[
                                    if (electryCityController.selectedSubCategoryList[0].fieldName != null)
                                      Text(
                                        electryCityController.selectedSubCategoryList[0].fieldName!,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    7.height,
                                    AppTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '*Required';
                                        }
                                        // else if (electryCityController.selectedSubCategoryList[0].fieldRegex != null &&
                                        //     !RegExp(electryCityController.selectedSubCategoryList[0].fieldRegex!)
                                        //         .hasMatch(value)) {
                                        //   return 'Please enter a valid ' +
                                        //       (electryCityController.selectedSubCategoryList[0].fieldName ?? '');
                                        // }
                                        return null;
                                      },
                                      decoration: waInputDecoration(
                                        hint: electryCityController.selectedSubCategoryList[0].fieldName ?? 'Enter value',
                                      ),
                                      textFieldType: TextFieldType.EMAIL,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: electryCityController.fieldNameController,
                                    ),
                                    if (electryCityController.selectedSubCategoryList[0].fieldNumber != null &&
                                        electryCityController.selectedSubCategoryList[0].fieldNumber!.isNotEmpty)
                                      ...[
                                        20.height,
                                        Text(
                                          electryCityController.selectedSubCategoryList[0].fieldNumber!,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        7.height,
                                        AppTextField(
                                          validator: (value) {
                                            if(1==1){
                                              if (value == null || value.isEmpty) {
                                                return '*Required';
                                              }
                                              // else if (electryCityController.selectedSubCategoryList[0].fieldRegex != null &&
                                              //     !RegExp(electryCityController.selectedSubCategoryList[0].fieldRegex!)
                                              //         .hasMatch(value)) {
                                              //   return 'Please enter a valid ' +
                                              //       (electryCityController.selectedSubCategoryList[0].fieldConnectionNo ?? '');
                                              // }
                                            }
                                            return null;
                                          },
                                          decoration: waInputDecoration(
                                            hint: electryCityController.selectedSubCategoryList[0].fieldNumber!,
                                          ),
                                          textFieldType: TextFieldType.EMAIL,
                                          keyboardType: TextInputType.emailAddress,
                                          controller: electryCityController.fieldNumberController,
                                        ),
                                      ],
                                  ],
                                  showAmountDetails(),
                                  20.height,
                                  AppButton(
                                    color: color.WAbtnColor,
                                    textColor: Colors.white,
                                    shapeBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    onTap: electryCityController.isLoading.value ? null : () {
                                      if (_formKey.currentState!.validate()){
                                        electryCityController.isVisibleFalseMessage.value = false;
                                        electryCityController.bbpsfirstField = electryCityController.fieldNameController.text;
                                        electryCityController.bbpsSecondField = electryCityController.fieldNumberController.text;
                                        electryCityController.offBillFetchApi();
                                      }

                                    },
                                    child: electryCityController.isLoading.value
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                      "Fetch Bill ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  10.height,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: electryCityController.isVisibleParam.value,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          ],
                        ),
                      )
                    ],
                  ).paddingAll(20),
                  electryCityController.isLoading.value
                      ? const Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator())
                      : Container(),
                ],
              ),
            );
          }),
        ));
  }
}
