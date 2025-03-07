import 'dart:async';

import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/screen/BBPS/BBPSPage.dart';
import 'package:PedhaPay/screen/BBPS/Electricity.dart';
import 'package:PedhaPay/screen/Credit%20Card/CreditCardPage.dart';
import 'package:PedhaPay/screen/Credit%20Card/LICPayments.dart';
import 'package:PedhaPay/screen/WALoginScreen.dart';
import 'package:PedhaPay/screen/profile%20details/fundList.dart';
import 'package:PedhaPay/screen/profile%20details/fundRequest.dart';
import 'package:PedhaPay/screen/profile%20details/rechargeHistory.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restart_app/restart_app.dart';
import '../utils/WADataGenerator.dart';
import 'Recharge/DTHRecharge.dart';
import 'Recharge/MobileRecharge.dart';
import 'package:marquee/marquee.dart' as mr;

class WAHomeScreen extends StatefulWidget {
  static String tag = '/WAHomeScreen';

  const WAHomeScreen({super.key});

  @override
  WAHomeScreenState createState() => WAHomeScreenState();
}

class WAHomeScreenState extends State<WAHomeScreen> {
  appController homeScreenController = Get.find();

  List cardList = waCardList();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late Timer timer;

  @override
  void initState() {
    timer = Timer(const Duration(milliseconds: 50), () {
      homeScreenController.getOffCategoryListApi();
      homeScreenController.getUserBalance();
      homeScreenController.dateAccess();
    });
    super.initState();
  }

  final List<Map<String, dynamic>> insurance = [
    {
      "icon": "http://apiv2.cityrecharge.in/icons/insurance.svg",
      "title": "INSURANCE",
      "serviceId": "9"
    },
    {
      "icon": "http://apiv2.cityrecharge.in/icons/emi.svg",
      "title": "EMI",
      "serviceId": "16"
    },
  ].obs;

  void _onRefresh() async {
    // your api here
    homeScreenController.isLoading.value = false;
    homeScreenController.getUserBalance();
    homeScreenController.getOffCategoryListApi();
    homeScreenController.dateAccess();
    _refreshController.refreshCompleted();
  }

  final List<Map<String, dynamic>> billPaymentOptions = [
    {
      "icon": Icons.electrical_services,
      "title": "Electricity",
      "serviceId": "7"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text(
                    'Are you sure want to leave?',
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          willLeave = true;
                          Get.offAll(const WALoginScreen());
                          Hive.box("id").put("is_login", false);
                          homeScreenController.isLoading.value = false;
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('No'))
                  ],
                ));
        return willLeave;
      },
      child: Obx(() {
        // Make sure the category list is populated before building the UI
        if (homeScreenController.getCategoryList.isEmpty) {
          homeScreenController.getOffCategoryListApi();
        }

        return Scaffold(
          drawer: const drawer(),
          appBar: AppBar(
            backgroundColor: const Color(0xFF410C60),
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              "Pedha Pay",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                // Adjust padding
                child: Center(
                  child: Obx(() => Text(
                        "₹ ${homeScreenController.getUserBalanceList.value.walletBalance?.toStringAsFixed(2) ?? '0.00'}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )),
                ),
              ),
            ],
          ),
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: mr.Marquee(
                    text: "Pedha Pay is a Recharge and Bill Payment Application which allows customers to process their daily needs transactions online with safe and easy mode.",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    // Adjust the speed here
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 2),
                    accelerationCurve: Curves.easeIn,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ).paddingAll(0),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.height,
                      homeScreenController.Slider(),
                      10.height,
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Get.to(const DTHRecharge(),
                                    transition: Transition.leftToRight);
                              },
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 19,
                                      child:
                                          Icon(Icons.tv,color: color.WASecondryColor,), // Access the SVG file
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  // Use SizedBox to provide spacing between widgets
                                  Text("DTH Recharge",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  homeScreenController.dthmode = "PREPAID";
                                  Get.to(const MobileRecharge(),
                                      transition: Transition.leftToRight);
                                },
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 19,
                                        child: Icon(Icons.smartphone,color: color.WASecondryColor),
                                      ),
                                    ),
                                    5.height,
                                    const Text("Mobile Recharge",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(const LICPayment(),
                                      transition: Transition.leftToRight);
                                },
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 19,
                                        child: Icon(Icons.policy,color: color.WASecondryColor),
                                      ),
                                    ),
                                    5.height,
                                    const Text(
                                      "LIC Premium",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(const CreditCardPage(),
                                      transition: Transition.leftToRight);
                                },
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 19,
                                        child: Icon(Icons.credit_card,color: color.WASecondryColor),
                                      ),
                                    ),
                                    5.height,
                                    const Text("Credit \nCard",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ).paddingAll(6),
                      ),
                      5.height,
                      const SectionTitle(title: "Offline Bill Payment"),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: billPaymentOptions.map((option) {
                          return FeatureCard(
                            icon:
                                'http://apiv2.cityrecharge.in/icons/electricity.svg',
                            // Use icon from the list
                            title: option["title"],
                            // Use title from the list
                            onTap: () {
                              if (option['title'] == "Electricity") {
                                homeScreenController.bbpsApiType = "1";
                                homeScreenController.serviceId =
                                    option['serviceId'];
                                homeScreenController.providerAlias =
                                    option['title'];
                                Get.to(const BBPSElectricity(),
                                    transition: Transition.leftToRight);
                              }
                              print("Selected: ${option["title"]}");
                            },
                          );
                        }).toList(),
                      ),

                      // Category List Grid
                      10.height,
                      const SectionTitle(title: "Online Bill Payment"),
                      Obx(() {
                        // Now the Grid will update when the list changes
                        return GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: homeScreenController.getCategoryList.value
                              .map((option) {
                            return FeatureCard(
                              icon: option.providerImage ?? "",
                              // Fallback for null values
                              title: option.providerAlias ?? "Unknown",
                              // Fallback for null values
                              onTap: () {
                                homeScreenController.bbpsApiType = "2";
                                homeScreenController.serviceId =
                                    option.serviceId?.toString() ?? "";
                                homeScreenController.providerAlias =
                                    option.providerAlias ?? "Unknown Provider";
                                Get.to(const BBPSElectricity(),
                                    transition: Transition.leftToRight);
                              },
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ).paddingAll(16),
                ),
                homeScreenController.isLoading.value
                    ? const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class QuickAction extends StatelessWidget {
  final IconData? icon;
  final String? label, img;
  final Color color;
  final VoidCallback onTap;

  const QuickAction({super.key, 
    this.icon,
    required this.label,
    this.img,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color.withOpacity(0.05),
              shape: BoxShape.rectangle,
            ),
            child: img != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: (img != null &&
                            (img!.startsWith('http://') ||
                                img!.startsWith('https://')))
                        ? Image.network(
                            img!,
                            height: 40,
                            width: 40,
                            color: color,
                            // fit: BoxFit.cover,
                          ).paddingAll(10)
                        : Image.asset(
                            img ?? 'assets/appLogo.png',
                            // Fallback to a placeholder if img is null
                            height: 40,
                            width: 40,
                            color: color,
                            // fit: BoxFit.cover,
                          ).paddingAll(10),
                  )
                : Icon(icon, color: color, size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            label!.length >= 9 ? "${label!.substring(0, 8)}..." : label!,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class ScheduledPayment extends StatelessWidget {
  final IconData icon;
  final String label;
  final String date;
  final String amount;
  final Color color;

  const ScheduledPayment({super.key, 
    required this.icon,
    required this.label,
    required this.date,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(label),
        subtitle: Text("Next Payment: $date"),
        trailing: Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
      ),
    );
  }
}

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  appController drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            accountName:
                Text(drawerController.P_loginDataList.value.shopName!),
            accountEmail:
                Text(drawerController.P_loginDataList.value.referId!),
            currentAccountPicture: ClipOval(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Image.asset(
                  'assets/appLogo.png',
                  width: 60,
                ),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text(
                    "Home ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.real_estate_agent),
                  title: const Text(
                    "Fund Request",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // drawerController.openDialog();
                    Get.to(const loadRequest());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text(
                    "Fund List",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    drawerController.generateMd5();
                    drawerController.txnMode = "FUNDREQUEST";
                    drawerController.LagerName = "Fund Request";
                    Get.to(() => const ViewRequestPage());
                    // Get.to(FundList());
                  },
                ),
                // ListTile(
                //   leading: const Icon(Icons.list),
                //   title: const Text(
                //     "Test Page",
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                //   onTap: () {
                //     Get.to(AEPSPage(),transition: Transition.leftToRight);
                //   },
                // ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                const Align(
                        alignment: Alignment.topLeft,
                        child: Text("List",
                            style: TextStyle(fontWeight: FontWeight.bold))).paddingOnly(left: 10),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text(
                    "Recharge List",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    drawerController.txnMode = "Mobile";
                    drawerController.historyMethod = "payestransaction_new";
                    drawerController.LagerName = "Mobile Recharge";
                    Get.to(const RechargeHistory());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text(
                    "BBPS List",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    drawerController.txnMode = "BBPS";
                    drawerController.historyMethod = "transbbps";
                    drawerController.LagerName = "BBPS";
                    Get.to(const RechargeHistory());

                    // Navigator.push(context, MaterialPageRoute(builder: (context) => company_list_Mr(merId: "",)));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text(
                    "LIC List",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    drawerController.historyMethod = "payestransaction_new";
                    drawerController.txnMode = "LIC";
                    drawerController.LagerName = "LIC";
                    Get.to(const RechargeHistory());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text(
                    "Credit Card List",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    drawerController.historyMethod = "payestransaction_new";
                    drawerController.txnMode = "CC";
                    drawerController.LagerName = "Credit Card";
                    Get.to(const RechargeHistory());
                  },
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    "Log Out ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Get.offAll(const WALoginScreen());

                    Hive.box("id").put("is_login", false);
                    drawerController.isLoading.value = false;
                    Restart.restartApp();
                    PopUp.toastMessage("Log Out Successfully");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
