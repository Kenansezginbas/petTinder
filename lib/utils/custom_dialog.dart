import 'package:flutter/material.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/widgets/custom_text_button.dart';

class CustomDialog {
  Future customShowDialog(BuildContext context, String errorMessage) {
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

  Future showProgress(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: CustomColors.blackIconColor,
          ),
        );
      },
    );
  }
}
