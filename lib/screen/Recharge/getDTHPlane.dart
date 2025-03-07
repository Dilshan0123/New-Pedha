import 'dart:async';

import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class DTHPlansScreen extends StatefulWidget {
  @override
  _DTHPlansScreenState createState() => _DTHPlansScreenState();
}

class _DTHPlansScreenState extends State<DTHPlansScreen> {


  appController dthPlanController = Get.find();

  String selectedCategory = 'All';

  List<Map<String, String>> dthPlans = [
    {"name": "Basic Pack", "price": "₹199", "validity": "30 Days", "channels": "100+", "type": "SD"},
    {"name": "HD Pack", "price": "₹399", "validity": "30 Days", "channels": "120+", "type": "HD"},
    {"name": "Sports Pack", "price": "₹299", "validity": "30 Days", "channels": "90+", "type": "Sports"},
    {"name": "Movies Pack", "price": "₹349", "validity": "30 Days", "channels": "110+", "type": "Movies"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DTH Plans",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
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
                      dthPlanController.providerImage,
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
                        dthPlanController.providerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dthPlanController.MobileNumber,
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
          // 🔹 DTH Plan List
          Expanded(
            child: ListView.builder(
              itemCount: dthPlans.length,
              itemBuilder: (context, index) {
                final plan = dthPlans[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(plan["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${plan["channels"]} Channels | ${plan["validity"]}"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(plan["price"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(content: Text("Recharge ${plan["name"]} for ${plan["price"]}!")),
                        //     );
                        //   },
                        //   child: Text("Recharge"),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
