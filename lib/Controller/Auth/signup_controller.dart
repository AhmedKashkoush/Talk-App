import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:talk_app/Core/Routes/routes.dart';
import 'package:intl/intl.dart' as intl;

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  String _countryCode = '+20';
  String get countryCode => _countryCode;

  String _gender = '';
  String get gender => _gender;

  bool _hiddenPassword = true;
  bool get hiddenPassword => _hiddenPassword;

  bool _hiddenConfirm = true;
  bool get hiddenConfirm => _hiddenConfirm;

  void togglePasswordVisibility() {
    _hiddenPassword = !_hiddenPassword;
    update();
  }

  void toggleConfirmVisibility() {
    _hiddenConfirm = !_hiddenConfirm;
    update();
  }

  String? nameValidator(String? value) {
    if (value!.isEmpty) return 'Write your name';
    if (value.length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  String? dobValidator(String? value) {
    if (value!.isEmpty) return 'Enter your date of birth';
    return null;
  }

  String? phoneValidator(String? value) {
    if (value!.isEmpty) return 'Write your phone';
    if (!value.isPhoneNumber) return 'Invalid Phone Number';
    return null;
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty) return 'Write your email';
    if (!value.isEmail) return 'Invalid Email';
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

  String? confirmValidator(String? value) {
    if (value!.isEmpty) return 'Write your password';
    if (value != passwordController.text) {
      return 'Write the same password to confirm';
    }
    return null;
  }

  void setGender(String? value) {
    _gender = value!;
    update();
  }

  void setCountryCode(CountryCode code) {
    _countryCode = code.dialCode ?? _countryCode;
    update();
  }

  void signUp() {
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
    if (_gender == '') {
      if (Get.isSnackbarOpen) Get.back();
      Get.rawSnackbar(
        message: 'You must detect your gender',
        icon: const Icon(
          Ionicons.warning_outline,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: const Duration(milliseconds: 500),
      );
    }
  }

  void showDate(BuildContext context) async {
    DateTime? _date = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dobController.text) ?? DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2100, 1, 1),
    );
    if (_date == null) return;
    dobController.text = intl.DateFormat.yMEd().format(_date);
    update();
  }

  void toLogin() {
    Get.offNamed(Routes.login);
  }
}
