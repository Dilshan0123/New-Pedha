import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:PedhaPay/view_model/appController.dart';

import '../model/WalletAppModel.dart';

class RetailerCard extends StatefulWidget {
  static String tag = '/WACardComponent';
  final WACardModel? cardModel;

  const RetailerCard({super.key, this.cardModel});

  @override
  RetailerCardState createState() => RetailerCardState();
}

class RetailerCardState extends State<RetailerCard>with TickerProviderStateMixin {

  appController retailerController = Get.find();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  final amountKey = GlobalKey<FormState>();

  String? payment_option;

  List<String> select_payment_list = [
    'To Wallet',
    'To Account'
  ];


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BC ID', style: boldTextStyle(color: Theme.of(context).primaryColor, size: 20)),
                    2.height,
                    // ${cardComponentController.dashBoardDataModel.value.walletBalance!.toString()}
                    Text(retailerController.P_loginDataList.value.referId??"", style: secondaryTextStyle(color: Colors.black, size: 16)),
                  ],
                ),
                10.width,
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: retailerController.appLogo(),
                  ),
                ),
              ],
            ),
            5.height,
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Wallet Balance', style: boldTextStyle(color: Theme.of(context).primaryColor,)),
                    Text("₹ ${retailerController.P_loginDataList.value.walletBalance}"?? "", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                  ],
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('AePS Balance', style: boldTextStyle(color: Theme.of(context).primaryColor,)),
                        Text("₹ ${retailerController.P_loginDataList.value.aepsBalance}"?? "", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).paddingAll(8);
      }
    );
  }
}

