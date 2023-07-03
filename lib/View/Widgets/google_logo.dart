import 'package:flutter/material.dart';
import 'package:talk_app/Core/Constants/images.dart';

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Images.google,
      width: 24,
      height: 24,
    );
  }
}
