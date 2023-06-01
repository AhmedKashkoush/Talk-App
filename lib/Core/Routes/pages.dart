import 'package:get/get.dart';
import 'package:talk_app/Core/Binding/chat_binding.dart';
import 'package:talk_app/Core/Routes/routes.dart';
import 'package:talk_app/View/Screens/chat_screen.dart';
import 'package:talk_app/View/Screens/join_screen.dart';

class Pages {
  static const String initial = Routes.join;
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.join,
      page: () => const JoinScreen(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => const ChatScreen(),
      binding: ChatBinding(),
    ),
  ];
}
