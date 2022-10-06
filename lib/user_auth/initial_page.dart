import 'package:flutter/material.dart';
import 'package:pet_tinder/database/database_helper.dart';
import 'package:pet_tinder/utils/custom_texts.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_logo_container.dart';
import 'package:pet_tinder/widgets/custom_icon_button.dart';
import 'package:pet_tinder/widgets/custom_text_widget.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  double widgetSpacing = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBody(),
    );
  }

  Center scaffoldBody() {
    return Center(
      child: myWrap(),
    );
  }

  Wrap myWrap() {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: widgetSpacing,
      children: [
        imageContainer(),
        welcomeText(),
        subtitleText(),
        startButton(),
      ],
    );
  }

  CustomLogoContainer imageContainer() {
    return const CustomLogoContainer(
      logoBckImage: ImageUrls.loginPageLogoBckUrl,
      logoCatImage: ImageUrls.loginPageLogoUrl,
    );
  }

  CustomTextWidget welcomeText() {
    return CustomTextWidget(
      text: CustomTexts.initialPageTitle,
      textStyle: CustomTextStyle.titleTextStyle,
    );
  }

  CustomTextWidget subtitleText() {
    return CustomTextWidget(
        text: CustomTexts.initialPageSubtitle,
        textStyle: CustomTextStyle.subtitleTextStyle);
  }

  CustomIconButton startButton() {
    return CustomIconButton(
      onPressed: () {
        Navigator.pushNamed(context, "/loginPage");
      },
      color: CustomColors.initialButtonColor,
      buttonText: "Başlayalım",
      height: .05,
      width: .20,
    );
  }
}
