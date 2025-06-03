import 'package:get/get.dart';

import '../screens/other_ui_controllers/homepage_controller.dart';


class GetXBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}