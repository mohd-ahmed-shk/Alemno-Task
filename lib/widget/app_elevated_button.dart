import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget title;
  final ButtonStyle style;

  const AppElevatedButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, style: style, child: title);
  }
}
