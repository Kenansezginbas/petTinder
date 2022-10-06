import 'package:flutter/material.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/widgets/custom_text_button.dart';

class CustomFunc {
  final errorMessage, context;
  CustomFunc({ required this.errorMessage,required this.context});
  Future customErrorShowDialog(String errorMessage) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Hata",
            style: CustomTextStyle.titleTextStyle,
          ),
          content: Text(
            errorMessage,
            style: CustomTextStyle.titleTextStyle,
          ),
          actions: [
            CustomTextButton(
              buttonText: "Geri Dön",
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}
