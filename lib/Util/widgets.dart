import 'package:flutter/material.dart';

import 'constants.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  const Button({super.key, required this.label, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: kButtonstyle,
      onPressed: onPress,
      child: Text(
        label,
        style: kButtonTextStyle,
      ),
    );
  }
}
