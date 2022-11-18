import 'package:flutter/material.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final buttonText;
  final GestureTapCallback onPressed;
  const CustomElevatedButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        buttonText,
        style: CustomTextStyle.buttonBlackTextStyle,
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffFEDE69),
      ),
    );
  }
}
