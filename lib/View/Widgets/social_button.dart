import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Widget icon;
  final Color? color, borderColor;
  final double borderRadius;
  const SocialButton({
    Key? key,
    this.onPressed,
    required this.label,
    required this.icon,
    this.borderColor,
    this.borderRadius = 0.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      label: Text(label),
      icon: icon,
      style: OutlinedButton.styleFrom(
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsets.all(18),
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        side: BorderSide(
          color: borderColor!,
        ),
      ),
    );
  }
}
