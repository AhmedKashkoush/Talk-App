import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:talk_app/Core/Routes/routes.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _hidden = true;
  bool get hidden => _hidden;

  void togglePasswordVisibility() {
    _hidden = !_hidden;
    update();
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty) return 'Write your email';
    if (!value.isEmail && !value.isPhoneNumber) return 'Invalid Email';
    return null;
  }

  String? passwordValidator(String? value) {
    String passRegex = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*?[!@#\$%*-])';
    RegExp regExp = RegExp(passRegex);
    if (value!.isEmpty) return 'Write your password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!regExp.hasMatch(value)) return 'Weak Password';
    return null;
  }

  void login() {
    if (!formKey.currentState!.validate()) {
      if (Get.isSnackbarOpen) Get.back();
      Get.rawSnackbar(
        message: 'Check your credentials',
        icon: const Icon(
          Ionicons.warning_outline,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: const Duration(milliseconds: 500),
      );
      return;
    }
  }

  void toSignUp() {
    Get.offNamed(Routes.signup);
  }

  void googleSignIn() {}
  void facebookSignIn() {}
}
