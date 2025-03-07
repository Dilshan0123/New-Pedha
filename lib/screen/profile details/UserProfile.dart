
import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/screen/WADashboardScreen.dart';
import 'package:PedhaPay/screen/WALoginScreen.dart';
import 'package:PedhaPay/screen/profile%20details/changePass.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';

import 'changeTPin.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  appController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        profileController.isVisiblePersonalDetails.value = false;
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            // Curved Header with Profile Picture and Name
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Custom Curved Background
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height *0.45,
                    decoration: const BoxDecoration(
                      color: color.WASecondryColor
                      // gradient: LinearGradient(
                      //   colors: [Color(0xFF0E6F85)],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),
                    ),
                  ),
                ),
                // Profile Picture and Name
                Positioned(
                  top: 40, // Adjust position to match the design
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // InkWell(
                          //     onTap: (){
                          //      Get.to(WADashboardScreen());
                          //     },
                          //     child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                          Expanded(
                            child: Text("User Profile",
                                style: boldTextStyle(size: 24, color: Colors.white)),
                          ),
                        ],
                      ).paddingOnly(left: 20,top: 20),
                      20.height,
                      const CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person,size: 80,),
                          // backgroundImage: AssetImage('assets/profile_picture.png'), // Replace with your image
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(profileController.P_loginDataList.value.referId!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      Text(profileController.P_loginDataList.value.shopName!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Additional Content Below
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  menuOption(context, Icons.person, "My Profile", () => showUserDetails(context, 'Profile')),
                  // menuOption(context, Icons.account_balance, "Account Details", () => showUserDetails(context, 'Account')),
                  menuOption(context, Icons.password, "Change Pass", (){
                    Get.to(const changePassword(), transition: Transition.leftToRight);
                  }),
                  // menuOption(context, Icons.pin_sharp, "Change M-Pin",(){
                  //   // Get.to(changePin());
                  // }),
                  menuOption(context, Icons.pin_sharp, "Change T-Pin", (){
                    Get.to(const changeTPin(),transition: Transition.leftToRight);
                  }),
                  Divider(
                    thickness: 1,
                    height: 30,
                    color: Colors.grey.shade300,
                  ),
                  logoutOption(Icons.logout, "Logout"),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget menuOption(BuildContext context, IconData icon, String title, VoidCallback? onTap,
      {Widget? trailing}) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }


  void showUserDetails(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if(title == "Account") ...[
                // const Text(
                //   "Account Details",
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // detailRow("Bank Name", profileController.P_loginDataList.value.shopName!),
                // detailRow("Account", profileController.P_loginDataList.value.email!),
                // detailRow("IFSC", profileController.P_loginDataList.value.mobile!),
                // detailRow("Branch", profileController.P_loginDataList.value.userType!),
              ] else if(title == "Profile") ...[
                const Text(
                  "User Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                detailRow("Name", profileController.P_loginDataList.value.shopName!),
                detailRow("Email", profileController.P_loginDataList.value.email!),
                detailRow("Phone", profileController.P_loginDataList.value.mobile!),
                detailRow("User Type", profileController.P_loginDataList.value.userType!),
                detailRow(
                    "Aadhaar",
                    (profileController.uAdhar != null && profileController.uAdhar.isNotEmpty)
                        ? "XXXXXXXX${profileController.uAdhar.substring(8)}"
                        : "Not Available"
                ),

                detailRow(
                    "Pan",
                    (profileController.uPan != null && profileController.uPan.isNotEmpty)
                        ? profileController.uPan
                        : "Not Available"
                ),

              ],


              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Close",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  // Badge Widget
  Widget badge(String value) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.purple,
        shape: BoxShape.circle,
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  // Logout Option Widget
  Widget logoutOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.red),
      ),
      onTap: () {
        Get.offAll(WALoginScreen());
        Hive.box("id").put("is_login", false);
      },
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
