import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nb_utils/nb_utils.dart';

import '../view_model/appController.dart';
import 'WALoginScreen.dart';
import 'WAVerificationScreen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> with TickerProviderStateMixin {

  appController SplashScreenController = Get.find();

  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    init();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700 ), // Adjust the duration of the animation
    );
    _animation = Tween<double>(
      begin: 0,
      end: 30, // Adjust the distance the arrow should move
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: true); // Reverse the animation to create a continuous loop
  }

  Future<void> init() async {
    // setStatusBarColor(color.WAPrimaryColor, statusBarIconBrightness: Brightness.light);
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) finish(context);
    // OpenAppPage().launch(context, isNewTask: true);
    ValueListenableBuilder(valueListenable: Hive.box("id").listenable(), builder: (context,Box box,widget){
      {
        return box.get("is_login",defaultValue: false) ? const WAVerificationScreen():const WALoginScreen();
      }
    }).launch(context, isNewTask: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              100.height,
              Image.asset("assets/appLogo.png",height: 100,),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Text(
                    "Explore your Business",textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Adine",
                        fontSize: 50),
                  ),
                  10.height,
                  const Text(
                    "The Platform to help your Business grow",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_animation.value, 0),
                        child: IconButton(
                          onPressed: () {
                            ValueListenableBuilder(
                              valueListenable: Hive.box("id").listenable(),
                              builder: (context, Box box, widget) {
                                return box.get("is_login", defaultValue: false)
                                    ? const WAVerificationScreen()
                                    : const WALoginScreen();
                              },
                            ).launch(context, isNewTask: true);
                          },
                          icon: const Row(
                            children: [
                              SizedBox(
                                width: 20, // Set your minimum width here
                                child: Icon(Icons.arrow_forward_ios, size: 50, color: Colors.white),
                              ),
                              SizedBox(
                                width: 20, // Set your minimum width here
                                child: Icon(Icons.arrow_forward_ios, size: 50, color: Colors.white),
                              ),
                              SizedBox(
                                width: 20, // Set your minimum width here
                                child: Icon(Icons.arrow_forward_ios, size: 50, color: Colors.white),
                              ),
                            ],
                          ).paddingOnly(left: MediaQuery.of(context).size.height * 0.1),
                        ),
                      );
                    },
                  ),

                ],
              ).paddingAll(15),
            ],
          ),
        ),
      ),
    );
  }
}
