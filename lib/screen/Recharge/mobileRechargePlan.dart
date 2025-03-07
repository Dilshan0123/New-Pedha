import 'dart:async';

import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class rechargePlane extends StatefulWidget {
  const rechargePlane({super.key});

  @override
  State<rechargePlane> createState() => _rechargePlaneState();
}

class _rechargePlaneState extends State<rechargePlane> {

  appController planController = Get.find();

  late Timer _timer;


  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 50), () {
      // SOMETHING
      planController.rechargeViewPlan();

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Mobile Recharge Plans',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2, // Subtle shadow
      ),
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Stack(
              children: [
                Column(
                  children: [
                    // Header Card with Provider Image, Name, and Number
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4, // Slight shadow for a modern look
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                planController.providerImage,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Provider Name and Mobile Number
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  planController.providerName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  planController.MobileNumber,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Search Bar with Custom Styling
                    TextField(
                      onChanged: (value) => planController.PlanSearchFilter(value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        hintText: "Search for plans",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Recharge Plan List
                    Expanded(
                      child: planController.rechargePlanData()
                    ),
                  ],
                ),

                // Loading Indicator (Centered on screen)
                if (planController.isLoading.value)
                  const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: Colors.blueAccent,
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
