import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DTHProvider extends StatefulWidget {
  const DTHProvider({super.key});

  @override
  State<DTHProvider> createState() => _DTHProviderState();
}

class _DTHProviderState extends State<DTHProvider> {

  appController providerController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Provider",style: TextStyle(color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: Colors.white,
        body: Obx(() {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 4 / 4,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 2),
                    itemCount: providerController.dthProviderList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          // color: Colors.amber,
                            borderRadius: BorderRadius.horizontal()),
                        child: Column(
                          children: [
                            CircleAvatar(
                              // backgroundColor: Colors.grey,
                              radius: 60,
                              child: Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    Get.back(result: providerController.dthProviderList[index]);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 50,
                                    child: Image.asset(
                                        providerController.dthProviderList[index].providerName! == "AIRTEL"
                                        ? "assets/Airtel.png"
                                        : providerController.dthProviderList[index].providerName! == "BSNL"
                                        ? "assets/bsnl.png"
                                        : providerController.dthProviderList[index].providerName! == "JIO"
                                        ? "assets/jio.png"
                                        : providerController.dthProviderList[index].providerName! == "IDEA"
                                        ? "assets/Idea.png"
                                        : providerController.dthProviderList[index].providerName! == "VODAFONE"
                                        ? "assets/Vodafone.png"
                                        : providerController.dthProviderList[index].providerName! == "DISH TV"
                                        ? "assets/dish_tv.png"
                                        : providerController.dthProviderList[index].providerName! == "TATA SKY"
                                        ? "assets/tata_tv.png"
                                        : providerController.dthProviderList[index].providerName! == "SUN TV"
                                        ? "assets/sun_tv.png"
                                        : providerController.dthProviderList[index].providerName! == "VIDEOCON D2H"
                                        ? "assets/d2h_tv.png"
                                        : providerController.dthProviderList[index].providerName! == "BIG TV"
                                        ? "assets/big_tv.png":
                                        providerController.dthProviderList[index].providerName! == "AIRTEL TV"?
                                        "assets/airtel_tv.png"
                                        : "assets.png",height: 50,width: 70,),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(providerController.dthProviderList[index].providerName!)
                          ],
                        ),
                      );
                    }),
              ),
            ).paddingOnly(top: 100);
          }
        )
    );
  }
}
