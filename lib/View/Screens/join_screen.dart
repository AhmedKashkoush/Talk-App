import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/Core/Routes/routes.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(onSubmitted: (value) {
          Get.toNamed(Routes.chat, arguments: {'email': value});
        }),
      ),
    );
  }
}
