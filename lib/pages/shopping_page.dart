import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';
import 'package:pet_tinder/widgets/shopping_container.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: NetworkImage(ImageUrls.loginPageLogoUrl)),
          Text(
            "Çok Yakında :)",
            style: CustomTextStyle.buttonBlackTextStyle,
          )
        ],
      ),
    ));
  }
}

//  GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: .8,
//         ),
//         itemBuilder: ((context, index) {
//           return ShoppingContainer(
//             itemName: "Deri Tasma",
//             brand: "Key",
//             price: "200 TL",
//           );
//         }),
//       ),
