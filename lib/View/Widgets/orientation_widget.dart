import 'package:flutter/material.dart';

class OrientationWidget extends StatelessWidget {
  final Widget portrait, landscape;
  const OrientationWidget({
    Key? key,
    required this.portrait,
    required this.landscape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) return portrait;
      return landscape;
    });
  }
}
