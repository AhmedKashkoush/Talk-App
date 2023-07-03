import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/Controller/Auth/login_controller.dart';
import 'package:talk_app/View/Widgets/auth_button.dart';
import 'package:talk_app/View/Widgets/custom_text_form_field.dart';
import 'package:talk_app/View/Widgets/google_logo.dart';
import 'package:talk_app/View/Widgets/orientation_widget.dart';
import 'package:talk_app/View/Widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
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
    });
  }
}

class _Portrait extends StatelessWidget {
  final LoginController controller;
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
            text: 'Welcome to ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
            children: [
              TextSpan(
                text: 'Talk!',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Connect your friends all over the world!',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        CustomTextFormField(
          hintText: 'ex: example@mail.com',
          label: 'Email',
          icon: Icons.email_outlined,
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
          obsecure: controller.hidden,
          validator: controller.passwordValidator,
          suffix: IconButton(
            onPressed: controller.togglePasswordVisibility,
            icon: controller.hidden
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        AuthButton(
          label: 'Login',
          onPressed: controller.login,
        ),
        const SizedBox(
          height: 15,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'If you don\'t have an account you can ',
            style: const TextStyle(
              color: Colors.grey,
            ),
            children: [
              TextSpan(
                text: 'Signup',
                recognizer: TapGestureRecognizer()..onTap = controller.toSignUp,
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
        Row(
          children: const [
            Expanded(
              child: Divider(
                thickness: 1,
                endIndent: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              'Or',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                indent: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SocialButton(
          onPressed: controller.googleSignIn,
          label: 'Sign in with Google',
          icon: const GoogleLogo(),
          color: Colors.black,
          borderColor: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        SocialButton(
          onPressed: controller.facebookSignIn,
          label: 'Sign in with Facebook',
          icon: const Icon(Icons.facebook_outlined),
          color: Colors.blue.shade400,
          borderColor: Colors.blue.shade400,
        ),
      ],
    );
  }
}

class _Landscape extends StatelessWidget {
  final LoginController controller;
  const _Landscape({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 56,
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
                    text: 'Welcome to ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                    children: [
                      TextSpan(
                        text: 'Talk!',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Connect your friends all over the world!',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 120),
              children: [
                CustomTextFormField(
                  hintText: 'ex: example@mail.com',
                  label: 'Email',
                  icon: Icons.email_outlined,
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
                  obsecure: controller.hidden,
                  validator: controller.passwordValidator,
                  suffix: IconButton(
                    onPressed: controller.togglePasswordVisibility,
                    icon: controller.hidden
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthButton(
                  label: 'Login',
                  onPressed: controller.login,
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'If you don\'t have an account you can ',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: 'Signup',
                        recognizer: TapGestureRecognizer()
                          ..onTap = controller.toSignUp,
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
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        endIndent: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Or',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        indent: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SocialButton(
                  onPressed: controller.googleSignIn,
                  label: 'Sign in with Google',
                  icon: const GoogleLogo(),
                  color: Colors.black,
                  borderColor: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                SocialButton(
                  onPressed: controller.facebookSignIn,
                  label: 'Sign in with Facebook',
                  icon: const Icon(Icons.facebook_outlined),
                  color: Colors.blue.shade400,
                  borderColor: Colors.blue.shade400,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
