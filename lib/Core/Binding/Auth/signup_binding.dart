import 'package:get/get.dart';
import 'package:talk_app/Controller/Auth/signup_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
  }
}
