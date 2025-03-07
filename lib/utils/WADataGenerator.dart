import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:PedhaPay/model/WalletAppModel.dart';
import 'package:get/get.dart';






List<WACardModel> waCardList() {
  List<WACardModel> cardList = [];
  cardList.add(WACardModel(color: Colors.black));
  return cardList;
}

appController demo = Get.find();

// List<WAOperationsModel> waOperationList() {
//   List<WAOperationsModel> operationModel = [];
//   operationModel.add(WAOperationsModel(
//     color: Colors.white,
//     title: 'DMT',
//     image: 'assets/dmt.png',
//     widget: DmtRemitter(),
//   ));
//   operationModel.add(WAOperationsModel(
//     color: Colors.white,
//     title: 'AEPS',
//     image: 'assets/aeps_report.png',
//     widget: AdhareKYC()
//   ));
//   operationModel.add(WAOperationsModel(
//     color: Color(0xFFFFFFFF),
//     title: 'Recharge',
//     image: 'assets/recharge.png',
//     widget: const MobileRecharge(),
//   ));
//   operationModel.add(WAOperationsModel(
//     color: Color(0xFFFFFFFF),
//     title: 'DTH',
//     image: 'assets/dth.png',
//     widget: DTHRecharge(),
//   ));
//   operationModel.add(WAOperationsModel(
//     color: Color(0xFFFFFFFF),
//     title: 'DTH',
//     image: 'assets/dth.png',
//     widget: DTHRecharge(),
//   ));
//   operationModel.add(WAOperationsModel(
//     color: Color(0xFFFFFFFF),
//     title: 'DTH',
//     image: 'assets/dth.png',
//     widget: DTHRecharge(),
//   ));
//   return operationModel;
// }

List<WAOperationsModel> waBillingList() {
  List<WAOperationsModel> operationModel = [];
  return operationModel;
}


