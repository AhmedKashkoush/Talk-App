import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText, label;
  final Widget? suffix;
  final IconData? icon;
  final bool obsecure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.label,
    this.suffix,
    this.icon,
    this.validator,
    this.obsecure = false,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obsecure,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        label: Text(label ?? ''),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: Colors.grey.shade500,
              )
            : null,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.blue.shade300,
          ),
        ),
      ),
    );
  }
}
