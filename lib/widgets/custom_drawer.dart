import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_text_button.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    var heigth = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(ImageUrls.loginPageLogoBckUrl),
                    fit: BoxFit.fill,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: heigth * .20,
                  width: width * .30,
                  child: Image.network(
                    ImageUrls.loginPageLogoUrl,
                    fit: BoxFit.contain,
                  ),
                )),
          ),
          // CustomTextButton(
          //     buttonText: "Alışveriş",
          //     onPressed: () {
          //       Navigator.pop(context);
          //       Get.toNamed("/shoppingPage");
          //     }),
          CustomTextButton(
            buttonText: "Hakkımızda",
            onPressed: () => Get.toNamed("/aboutUS"),
          ),
          CustomTextButton(
            buttonText: "Bize Ulaşın",
            onPressed: () => Get.toNamed("/contactUS"),
          ),
        ],
      ),
    );
  }
}
