import 'package:flutter/material.dart';
import 'package:pet_tinder/utils/custom_colors.dart';

import '../utils/custom_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;
  final List<Widget> actions;
  const CustomAppBar({super.key, required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: CustomTextStyle.appBarTextStyle),
      centerTitle: true,
      iconTheme: IconThemeData(color: CustomColors.turquoiseColor, size: 25),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
