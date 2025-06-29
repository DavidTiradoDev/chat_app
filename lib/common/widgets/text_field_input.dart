import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.autoCorrect,
    required this.keyboardType,
    required this.obscureText,
    required this.icons,
    required this.hintText,
    required this.textEditingController,
    this.maxLength,
  });

  final bool autoCorrect;
  final bool obscureText;
  final TextInputType keyboardType;
  final String hintText;
  final IconData icons;
  final TextEditingController textEditingController;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        autocorrect: autoCorrect,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icons),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText,
        ),
        maxLength: maxLength,
      ),
    );
  }
}
