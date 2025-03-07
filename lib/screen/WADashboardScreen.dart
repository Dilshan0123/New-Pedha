import 'package:PedhaPay/screen/WAHomeScreen.dart';
import 'package:PedhaPay/screen/profile%20details/UserProfile.dart';
import 'package:PedhaPay/screen/profile%20details/WalletTxn.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';

import 'WALoginScreen.dart';




class WADashboardScreen extends StatefulWidget {
  static String tag = '/WADashboardScreen';
  const WADashboardScreen({super.key});

  @override
  WADashboardScreenState createState() => WADashboardScreenState();
}

class WADashboardScreenState extends State<WADashboardScreen> {

  appController dashboardController = Get.find();

  @override
  void initState() {
    dashboardController.checkVersion();
    // TODO: implement initState
    super.initState();
  }

  int _selectedIndex = 0;
  // final _pages = <Widget>[
  //   const WAHomeScreen(),
  //   // OnlineBillPayment(),
  // ];

  // List of nav items
  final List<Map<String, dynamic>> _navitems = [
    {"icon": Icons.home, "title": "Home"},
    {"icon": Icons.person, "title": "Profile"},
    {"icon": Icons.account_balance_wallet, "title": "Main Ledger"},
  ];


// Screens
  final List<Widget> _screens = [
    const WAHomeScreen(),
    const UserProfile(),
    const WalletTxn(),
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
                      dashboardController.isLoading.value = false;
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
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: CupertinoTabBar(
          onTap: (value) {
            dashboardController.dateinput.clear();
            dashboardController.toDateInput.clear();
            dashboardController.search.clear();
            setState(() {
              _selectedIndex = value;
            });
          },
          currentIndex: _selectedIndex,
          activeColor: color.WASecondryColor,
          inactiveColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          items: List.generate(
            _navitems.length,
                (index) => BottomNavigationBarItem(
                  icon: Icon(_navitems[index]["icon"], size: 24),
                  label: _navitems[index]["title"]!,
            ),
          ),
        ),
      ),
    );
  }
}



