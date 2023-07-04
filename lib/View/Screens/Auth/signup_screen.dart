import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/Controller/Auth/signup_controller.dart';
import 'package:talk_app/View/Widgets/auth_button.dart';
import 'package:talk_app/View/Widgets/custom_text_form_field.dart';
import 'package:talk_app/View/Widgets/gender_field.dart';
import 'package:talk_app/View/Widgets/orientation_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Scaffold(
          body: Form(
            key: controller.formKey,
            child: OrientationWidget(
              portrait: _Portrait(
                controller: controller,
              ),
              landscape: _Landscape(
                controller: controller,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Portrait extends StatelessWidget {
  final SignUpController controller;
  const _Portrait({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 56,
      ),
      children: [
        RichText(
          text: const TextSpan(
            text: 'Create a new ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
            children: [
              TextSpan(
                text: 'Talk ',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              TextSpan(
                text: 'Account!',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Provide us some information about you to complete registration process',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                hintText: 'ex: Henry',
                label: 'First Name',
                controller: controller.fnameController,
                icon: Icons.person_outline,
                validator: controller.nameValidator,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: CustomTextFormField(
                hintText: 'ex: Handrson',
                label: 'Last Name',
                controller: controller.lnameController,
                icon: Icons.person_outline,
                validator: controller.nameValidator,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          hintText: 'DD/MM/YYYY',
          label: 'DOB',
          icon: Icons.date_range_outlined,
          controller: controller.dobController,
          readOnly: true,
          onTap: () {
            controller.showDate(context);
          },
          validator: controller.dobValidator,
        ),
        const SizedBox(
          height: 15,
        ),
        GenderField(
          value: controller.gender,
          onChanged: controller.setGender,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.blue.shade300,
                  ),
                ),
                child: CountryCodePicker(
                  padding: const EdgeInsets.all(14),
                  initialSelection: controller.countryCode,
                  onChanged: controller.setCountryCode,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: CustomTextFormField(
                hintText: 'ex: 12********',
                label: 'Phone',
                icon: Icons.phone_outlined,
                maxLength: 10,
                controller: controller.phoneController,
                validator: controller.phoneValidator,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          hintText: 'ex: example@mail.com',
          label: 'Email',
          icon: Icons.email_outlined,
          controller: controller.emailController,
          validator: controller.emailValidator,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          hintText: 'at least 8 characters [0-9,A-Z,a-z,!@#\$%^&*()]',
          label: 'Password',
          icon: Icons.password_outlined,
          obsecure: controller.hiddenPassword,
          validator: controller.passwordValidator,
          controller: controller.passwordController,
          suffix: IconButton(
            onPressed: controller.togglePasswordVisibility,
            icon: controller.hiddenPassword
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          hintText: 'Write the same password above',
          label: 'Confirm Passowrd',
          icon: Icons.password_outlined,
          obsecure: controller.hiddenConfirm,
          validator: controller.confirmValidator,
          controller: controller.confirmController,
          suffix: IconButton(
            onPressed: controller.toggleConfirmVisibility,
            icon: controller.hiddenConfirm
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'If you already have an account you can ',
            style: const TextStyle(
              color: Colors.grey,
            ),
            children: [
              TextSpan(
                text: 'Login',
                recognizer: TapGestureRecognizer()..onTap = controller.toLogin,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        AuthButton(
          label: 'Register',
          onPressed: controller.signUp,
        ),
      ],
    );
  }
}

class _Landscape extends StatelessWidget {
  final SignUpController controller;
  const _Landscape({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Create a new ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                    children: [
                      TextSpan(
                        text: 'Talk ',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: 'Account!',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Provide us some information about you to complete registration process',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        hintText: 'ex: Henry',
                        label: 'First Name',
                        controller: controller.fnameController,
                        icon: Icons.person_outline,
                        validator: controller.nameValidator,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        hintText: 'ex: Handrson',
                        label: 'Last Name',
                        controller: controller.lnameController,
                        icon: Icons.person_outline,
                        validator: controller.nameValidator,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: 'DD/MM/YYYY',
                  label: 'DOB',
                  icon: Icons.date_range_outlined,
                  controller: controller.dobController,
                  readOnly: true,
                  onTap: () {
                    controller.showDate(context);
                  },
                  validator: controller.dobValidator,
                ),
                const SizedBox(
                  height: 15,
                ),
                GenderField(
                  value: controller.gender,
                  onChanged: controller.setGender,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.blue.shade300,
                          ),
                        ),
                        child: CountryCodePicker(
                          padding: const EdgeInsets.all(14),
                          initialSelection: controller.countryCode,
                          onChanged: controller.setCountryCode,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                        hintText: 'ex: 12********',
                        label: 'Phone',
                        icon: Icons.phone_outlined,
                        maxLength: 10,
                        controller: controller.phoneController,
                        validator: controller.phoneValidator,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: 'ex: example@mail.com',
                  label: 'Email',
                  icon: Icons.email_outlined,
                  controller: controller.emailController,
                  validator: controller.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: 'at least 8 characters [0-9,A-Z,a-z,!@#\$%^&*()]',
                  label: 'Password',
                  icon: Icons.password_outlined,
                  obsecure: controller.hiddenPassword,
                  validator: controller.passwordValidator,
                  controller: controller.passwordController,
                  suffix: IconButton(
                    onPressed: controller.togglePasswordVisibility,
                    icon: controller.hiddenPassword
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: 'Write the same password above',
                  label: 'Confirm Passowrd',
                  icon: Icons.password_outlined,
                  obsecure: controller.hiddenConfirm,
                  validator: controller.confirmValidator,
                  controller: controller.confirmController,
                  suffix: IconButton(
                    onPressed: controller.toggleConfirmVisibility,
                    icon: controller.hiddenConfirm
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'If you already have an account you can ',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = controller.toLogin,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthButton(
                  label: 'Register',
                  onPressed: controller.signUp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
