import 'dart:async';

import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/screen/BBPS/Electricity.dart';
import 'package:PedhaPay/screen/Credit%20Card/CreditCardPage.dart';
import 'package:PedhaPay/screen/Credit%20Card/LICPayments.dart';
import 'package:PedhaPay/screen/Recharge/DTHRecharge.dart';
import 'package:PedhaPay/screen/Recharge/MobileRecharge.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:marquee/marquee.dart'as mr;

import '../WAHomeScreen.dart';

class BBPSPage extends StatefulWidget {
  const BBPSPage({super.key});

  @override
  State<BBPSPage> createState() => _BBPSPageState();
}

class _BBPSPageState extends State<BBPSPage> {


  appController BBPSController = Get.find();
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 50), () {
      BBPSController.getOffCategoryListApi();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bill Payment", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      BBPSController.getOffCategoryListApi();
                      BBPSController.bbpsService.value = "online";
                      Get.to(() => const OnlineBillPayment());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            "https://www.chsone.in/blog/wp-content/uploads/2018/12/main-qimg-567c14547149fdb9a5212a09d8166369.jpeg",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        const Divider(),
                        const Text(
                          "Online Bill Payment",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      BBPSController.bbpsService.value = "offline";
                      Get.to(() => const OfflineBillPayment());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/Offline_bill.png",
                        ),
                        const Divider(),
                        const Text(
                          "Offline Bill Payment",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ).paddingAll(16),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Note: Please ensure that your payment details are accurate.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class OnlineBillPayment extends StatefulWidget {
  const OnlineBillPayment({super.key});

  @override
  State<OnlineBillPayment> createState() => _OnlineBillPaymentState();
}

class _OnlineBillPaymentState extends State<OnlineBillPayment> {


  appController payBillController = Get.put(appController());

  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 50), () {
      payBillController.getOffCategoryListApi();
    });

    _pageController = PageController(initialPage: 0);

    // Set up the automatic sliding
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        if (initialIndex.value < sliderItems.length - 1) {
          // Move to the next page
          initialIndex.value++;
        } else {
          // Reset to the first page when the last page is reached
          initialIndex.value = 0;
        }

        _pageController.animateToPage(
          initialIndex.value,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }


  final List<Map<String, dynamic>> insurance = [
    {"icon": "http://apiv2.cityrecharge.in/icons/insurance.svg", "title": "INSURANCE", "serviceId": "9"},
    {"icon": "http://apiv2.cityrecharge.in/icons/emi.svg", "title": "EMI", "serviceId": "16"},
  ].obs;

  final List<Map<String, dynamic>> sliderItems = [
    {'icon': Icons.tv, 'title': 'DTH Recharge'},
    {'icon': Icons.smartphone, 'title': 'Mobile Recharge'},
    {'icon': Icons.policy, 'title': 'LIC Premium'},
    {'icon': Icons.credit_card, 'title': 'Credit Card'},
  ];

  final RxInt initialIndex = 0.obs;

  @override
  Widget build(BuildContext context) {

    // Access the original list
    var categoryList = payBillController.getCategoryList.value;

// Step 1: Clear the insurance list before processing
    payBillController.insuranceList.value.clear();

// Step 2: Remove specified items from the original list and add them to the insurance list
    categoryList.removeWhere((option) {
      if (option.providerAlias == "EMI" || option.providerAlias == "INSURANCE") {// Add removed item to the insurance list
        return true; // Mark for removal from the original list
      }
      return false; // Keep in the original list
    });

// Step 3: Assign the updated list back to the controller
    payBillController.getCategoryList.value = categoryList;



    return  Scaffold(
      drawer: const drawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E6F85),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding
            child: Center(
              child: Obx(() => Text(
                "₹ ${payBillController.P_loginDataList.value.walletBalance?.toStringAsFixed(2) ?? '0.00'}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
            ),
          ),        // IconButton(
          //   icon: Icon(Icons.settings),
          //   onPressed: () {
          //     // Add your action here
          //     print("Settings clicked");
          //   },
          // ),
        ],
      ),
      body: Obx(() {
          return Column(
            children: [
              // Top Banner
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
                  velocity: 100.0,  // Adjust the speed here7846586346
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 2),
                  accelerationCurve: Curves.easeIn,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ).paddingAll(0),
              ),

              // Categories
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [

                      AspectRatio(
                        aspectRatio: 2.5,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              onPageChanged: (value) {
                                initialIndex.value = value; // Update reactive variable
                              },
                              itemCount: sliderItems.length,
                              itemBuilder: (context, index) => BigCardItem(
                                icon: sliderItems[index]['icon'],
                                title: sliderItems[index]['title'],
                                onTap: (){
                                  if(sliderItems[index]['title'] == "Mobile Recharge"){
                                    payBillController.dthmode = "PREPAID";
                                    Get.to(const MobileRecharge(),transition: Transition.leftToRight);
                                  }else if(sliderItems[index]['title'] == "DTH Recharge"){
                                    Get.to(const DTHRecharge(),transition: Transition.leftToRight);
                                  }else if(sliderItems[index]['title'] == "LIC Premium"){
                                    Get.to(const LICPayment(),transition: Transition.leftToRight);
                                  }else if(sliderItems[index]['title'] == "Credit Card"){
                                    Get.to(const CreditCardPage(),transition: Transition.leftToRight);
                                  }else{
                                    PopUp.toastErrorMessage("Invalid hit !!");
                                  }
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0, // Adjust based on design
                              left: 0,
                              right: 0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.center, // Center the indicators
                                    children: List.generate(
                                      sliderItems.length,
                                          (index) => DotIndicator(
                                        isActive: initialIndex.value == index, // Reactive update
                                        activeColor: Colors.white,
                                        inActiveColor: Colors.grey,
                                      ),
                                    ),
                                  )),
                                  const SizedBox(height: 8), // Optional spacing below indicators
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SectionTitle(title: "Services"),
                      // GridView.count(
                      //   crossAxisCount: 3,
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   crossAxisSpacing: 1,
                      //   mainAxisSpacing: 20,
                      //   children: [
                      //     FeatureCard(
                      //       icon: "Icons.smartphone", // Use appropriate icon for Mobile Recharge
                      //       title: "Mobile",
                      //       onTap: () {
                      //         // Get.to(MobileRechargePage(), transition: Transition.leftToRight);
                      //       },
                      //     ),
                      //     FeatureCard(
                      //       icon: "Icons.tv", // Use appropriate icon for DTH
                      //       title: "DTH",
                      //       onTap: () {
                      //         // Get.to(DTHPage(), transition: Transition.leftToRight);
                      //       },
                      //     ),
                      //     FeatureCard(
                      //       icon: "Icons.credit_card", // Use appropriate icon for Credit Card
                      //       title: "Credit Card",
                      //       onTap: () {
                      //         // Get.to(CreditCardPaymentPage(), transition: Transition.leftToRight);
                      //       },
                      //     ),
                      //     FeatureCard(
                      //       icon: "Icons.policy", // Use appropriate icon for LIC
                      //       title: "LIC",
                      //       onTap: () {
                      //         // Get.to(LICPaymentPage(), transition: Transition.leftToRight);
                      //       },
                      //     ),
                      //   ],
                      // ),

                      const SectionTitle(title: "Offline Bill Payment"),
                      InkWell(
                        onTap: () {
                          // Navigate to the Offline Bill Payment page or show a form
                          Get.to(const OfflineBillPayment(), transition: Transition.leftToRight);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.offline_pin, size: 40, color: Theme.of(context).primaryColor),
                              const SizedBox(width: 16),
                              const Expanded(child: Text(
                                "Pay Offline",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),),
                              Expanded(child: Icon(Icons.arrow_circle_right_outlined, color: Theme.of(context).primaryColor))
                            ],
                          ),
                        ),
                      ),
                      20.height,
                      // Utility Bill Payment Section
                      const SectionTitle(title: "Utility Bill Payment"),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: categoryList.map((option) {
                          return FeatureCard(
                            icon: option.providerImage!,
                            title: option.providerAlias!,
                            onTap: () {
                              payBillController.serviceId = option.serviceId!.toString();
                              payBillController.providerAlias = option.providerAlias!;
                              Get.to(const BBPSElectricity(), transition: Transition.leftToRight);
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 16),

                      // Finance & Taxes Section
                      const SectionTitle(title: "Finance & Taxes"),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: insurance.map((option) {
                          return FeatureCard(
                            icon: option['icon'],
                            title: option["title"],
                            onTap: () {
                              payBillController.serviceId = option['serviceId'];
                              payBillController.providerAlias = option['title'];
                              Get.to(const BBPSElectricity(), transition: Transition.leftToRight);
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 16),

                      // Offline Bill Payment Sectio
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class BigCardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const BigCardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the navigation on tap
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DotIndicator extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color inActiveColor;

  const DotIndicator({
    super.key,
    required this.isActive,
    required this.activeColor,
    required this.inActiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 16.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}

class OfflineBillPayment extends StatefulWidget {
  const OfflineBillPayment({super.key});

  @override
  State<OfflineBillPayment> createState() => _OfflineBillPaymentState();
}

class _OfflineBillPaymentState extends State<OfflineBillPayment> {

  appController payBillController = Get.find();

  final List<Map<String, dynamic>> billPaymentOptions = [
    {"icon": Icons.electrical_services, "title": "Electricity", "serviceId": "7"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Pay bill",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Top Banner
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
          ),

          // Categories
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Bill Payment Section
                  const SectionTitle(title: "Bill Payment"),
                  GridView.count(
                    crossAxisCount: 3, // Number of columns
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Prevents scrolling within the grid
                    crossAxisSpacing: 10, // Space between columns
                    mainAxisSpacing: 10, // Space between rows
                    children: billPaymentOptions.map((option) {
                      return FeatureCard(
                        icon: 'http://apiv2.cityrecharge.in/icons/electricity.svg', // Use icon from the list
                        title: option["title"], // Use title from the list
                        onTap: () {
                          if (option['title'] == "Electricity") {
                            payBillController.serviceId = option['serviceId'];
                            payBillController.providerAlias = option['title'];
                            Get.to(const BBPSElectricity(), transition: Transition.leftToRight);
                          }
                          // Handle tap for each option
                          print("Selected: ${option["title"]}");
                        },
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class FeatureCard extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const FeatureCard({super.key, 
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon.endsWith('.svg'))
              SvgPicture.network(
                icon,
                height: 30,
                placeholderBuilder: (BuildContext context) =>
                    const CircularProgressIndicator(), // Optional placeholder
              )
            else
              Image.network(
                icon,
                height: 30,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 30), // Fallback for invalid PNG URLs
              ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        )
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}