import 'package:flutter/material.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_text_widget.dart';

class ShoppingContainer extends StatelessWidget {
  final itemName, brand, price, imageURL;
  const ShoppingContainer(
      {super.key, this.itemName, this.brand, this.price, this.imageURL});

  @override
  Widget build(BuildContext context)  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width * .10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .15,
              child: Image(image: NetworkImage(ImageUrls.loginPageLogoUrl)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CustomTextWidget(
                      text: itemName,
                      textStyle: CustomTextStyle.subtitleTextStyle,
                    ),
                    CustomTextWidget(
                      text: brand,
                      textStyle: CustomTextStyle.subtitleTextStyle,
                    ),
                    CustomTextWidget(
                      text: price,
                      textStyle: CustomTextStyle.priceTextStyle,
                    ),
                  ],
                ),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: CustomColors.colorCardColor,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.black,
                    size: 20,
                  ),
                  mini: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
