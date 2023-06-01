import 'package:get/get.dart';
import 'package:talk_app/Controller/chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}
