import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({super.key});

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (() => Navigator.pushNamed(context, "/addNewPost")),
      child: Icon(
        CupertinoIcons.add,
        color: Colors.white,
        size: 35,
      ),
      backgroundColor: CustomColors.typeCardColor,
      elevation: 40,
      shape: StadiumBorder(
        side: BorderSide(width: 3, color: CustomColors.colorCardColor),
      ),
    );
  }
}
