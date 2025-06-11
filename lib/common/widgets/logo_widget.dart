import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 30),
        Image.asset('assets/tag-logo.png', width: 170),
        SizedBox(height: 20),
        Text(title, style: TextStyle(fontSize: 30)),
      ],
    );
  }
}
