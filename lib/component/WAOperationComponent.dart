import 'package:PedhaPay/utils/WAColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/WADataGenerator.dart';
import '../view_model/appController.dart';

class WAOperationComponent extends StatefulWidget {
  static String tag = '/WAOperationComponent';
  final dynamic itemModel;
  final bool isApplyColor;

  const WAOperationComponent({super.key, this.itemModel, this.isApplyColor = false});

  @override
  WAOperationComponentState createState() => WAOperationComponentState();
}

class WAOperationComponentState extends State<WAOperationComponent> {

  appController moneyTransferScreen = Get.find();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: boxDecorationRoundedWithShadow(
            16,
            backgroundColor: widget.isApplyColor ? widget.itemModel!.color!.withOpacity(0.1) : Colors.grey,
            shadowColor: widget.isApplyColor ? Colors.transparent : Colors.grey.withOpacity(0.2),
          ),
          child: ImageIcon(AssetImage('${widget.itemModel!.image!}'), size: 30,),
        ),
        8.height,
        Text('${widget.itemModel.title}', style: boldTextStyle(size: 14, color: Colors.white), textAlign: TextAlign.center, maxLines: 1),
      ],
    );
  }
}



class OperationComponent3 extends StatefulWidget {
  static String tag = '/WAOperationComponent';
  final dynamic itemModel;
  final bool isApplyColor;

  const OperationComponent3({super.key, this.itemModel, this.isApplyColor = false});

  @override
  OperationComponent3State createState() => OperationComponent3State();
}

class OperationComponent3State extends State<OperationComponent3> {

  appController moneyTransferScreen = Get.find();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  List billingList = waBillingList();


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: color.BackGroundColor3,
          child: GridView.builder(
            itemCount: billingList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 30.0
            ),
            itemBuilder: (operationModel, int index){
              return InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => billingList));
                  // operationModel.widget != null ? operationModel.widget.launch(context) : toast(operationModel.title);
                },
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: color.WACardColor,
                        child: Image.asset(billingList[index].image!, height: 30,)),
                    const SizedBox(height: 10,),
                    Expanded(child: Text(billingList[index].title!)
                    ),
                  ],
                ),
              );
            },
          ).paddingAll(20),
        ),],
    );
  }
}