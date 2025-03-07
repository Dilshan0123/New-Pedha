import 'dart:io';
import 'package:PedhaPay/component/Popup/popUp.dart';
import 'package:PedhaPay/screen/SplaceScreenPage.dart';
import 'package:PedhaPay/screen/WADashboardScreen.dart';
import 'package:PedhaPay/screen/WALoginScreen.dart';
import 'package:PedhaPay/screen/WAVerificationScreen.dart';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nb_utils/nb_utils.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=>true;
  }
}

void main() async{

  await Hive.initFlutter();
  await Hive.openBox('id');

  Get.put(appController(),permanent: true);

  HttpOverrides.global = MyHttpOverrides();
  // init flutter hive
  Box box = Hive.box("id");
  bool isLoggedIn = box.get("is_login", defaultValue: false);

  runApp(MyApp(startScreen: isLoggedIn ? WAVerificationScreen() : WALoginScreen()));
}
class MyApp extends StatelessWidget {
  final Widget? startScreen;

   MyApp({super.key, this.startScreen});

  appController demController = Get.find();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(int.parse(demController.colorCode))),
      // initialBinding: NetworkBinding(),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
          return demController.connectionStatus.value != 0? const internet_connection()
              :demController.P_loginDataList.value.status == "S"? const WADashboardScreen()
              // : demController.isLoggedOut.value == true? demo5()
              // : demController.version != demController.appVersion? checkAppVersion()
              : startScreen!;
        }
      ),
    );
  }
}

class internet_connection extends StatefulWidget {
  const internet_connection({super.key});

  @override
  State<internet_connection> createState() => _internet_connectionState();
}

class _internet_connectionState extends State<internet_connection> {

  appController failedController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                  child: const Icon(Icons.signal_wifi_connected_no_internet_4_outlined,size: 40,)
              ),
              const SizedBox(height: 10,),
              const Text('You are offline',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              const SizedBox(height: 10,),
              const Text('Check your connection or get a notification when you are ',),
              20.height,
              AppButton(
                  text: "Reload",
                  color: color.WAbtnColor,
                  textColor: Colors.white,
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  width:  MediaQuery.of(context).size.width,
                  onTap: () {
                    if(failedController.connectionStatus.value == 0){
                      PopUp.toastMessage("Still you are offline \n Please Connect Internet !!");
                    }else{
                      Get.back();
                    }
                  }).paddingOnly(left: MediaQuery.of(context).size.height * 0.1, right: MediaQuery.of(context).size.width * 0.2),

            ],
          ).paddingOnly(top: MediaQuery.of(context).size.height *0.4, left: 20,right: 20)
        ),
      ),
    );
  }
}


class checkAppVersion extends StatefulWidget {
  const checkAppVersion({super.key});

  @override
  State<checkAppVersion> createState() => _checkAppVersionState();
}

class _checkAppVersionState extends State<checkAppVersion> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check App Version'),
        backgroundColor: Colors.teal,
      ),
      body: const SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("idhsfiuhuihuiwefs",style: TextStyle(fontFamily: "Facon", fontSize: 20),)
          ],
        ),
      ),
    );
  }
}


// AppButton(
// text: "Loading...",
// textColor: Colors.white,
// color: color.WAbtnColor,
// shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
// width:  MediaQuery.of(context).size.width,
// onTap: (){},
// )


// changePassController.isLoading.value? Align(
// alignment: Alignment.center,
// child: CircularProgressIndicator()): Text("Submit",style: TextStyle(color: Colors.white),),
