import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  const AuthButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(18),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
