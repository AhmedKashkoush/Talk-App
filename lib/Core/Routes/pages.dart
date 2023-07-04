import 'package:get/get.dart';
import 'package:talk_app/Core/Binding/Auth/login_binding.dart';
import 'package:talk_app/Core/Binding/Auth/signup_binding.dart';
import 'package:talk_app/Core/Binding/chat_binding.dart';
import 'package:talk_app/Core/Middlewares/auth_middleware.dart';
import 'package:talk_app/Core/Routes/routes.dart';
import 'package:talk_app/View/Screens/Auth/login_screen.dart';
import 'package:talk_app/View/Screens/Auth/signup_screen.dart';
import 'package:talk_app/View/Screens/chat_screen.dart';
import 'package:talk_app/View/Screens/join_screen.dart';

class Pages {
  static const String initial = Routes.login;
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.join,
      page: () => const JoinScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => const ChatScreen(),
      binding: ChatBinding(),
    ),
  ];
}
