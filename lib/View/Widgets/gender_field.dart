import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class GenderField extends StatelessWidget {
  final String value;
  final void Function(String?)? onChanged;
  const GenderField({
    Key? key,
    this.value = '',
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.blue.shade300,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: RadioListTile(
                title: const Text('Male'),
                secondary: Icon(
                  Ionicons.male_outline,
                  color: value == 'male' ? Colors.blue : null,
                ),
                groupValue: value,
                onChanged: onChanged,
                value: 'male',
              ),
            ),
            const VerticalDivider(
              thickness: 2,
              width: 0,
            ),
            Expanded(
              child: RadioListTile(
                title: const Text('Female'),
                secondary: Icon(
                  Ionicons.female_outline,
                  color: value == 'female' ? Colors.blue : null,
                ),
                groupValue: value,
                onChanged: onChanged,
                value: 'female',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
