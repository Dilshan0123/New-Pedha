


import 'package:PedhaPay/view_model/appController.dart';
import 'package:get/get.dart';

class NetworkBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<appController>(() => appController());
  }
}