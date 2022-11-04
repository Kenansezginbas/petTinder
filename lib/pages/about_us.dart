import 'package:flutter/material.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';
import 'package:pet_tinder/widgets/custom_text_widget.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Hakkımızda";
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //here will change
            CustomTextWidget(
              text: "Bu Bir Keyoz Teknoloji Ürünüdür.",
              textStyle: CustomTextStyle.titleTextStyle,
            ),
            CustomTextWidget(
              text: "Versiyon 1.0",
              textStyle: CustomTextStyle.titleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
