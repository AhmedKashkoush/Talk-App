import 'package:get/get.dart';
import 'package:talk_app/Controller/Auth/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
