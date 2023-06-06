import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/Core/Routes/routes.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController to = TextEditingController();
    // String to = '';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'from'),
            ),
            TextField(
              controller: to,
              decoration: const InputDecoration(hintText: 'to'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.chat,
                    arguments: {'email': email.text, 'to': to.text});
              },
              child: const Text('Join'),
            )
          ],
        ),
      ),
    );
  }
}
