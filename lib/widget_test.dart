import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_tinder/pages/blog_page.dart';
import 'package:pet_tinder/pages/home_page.dart';
import 'package:pet_tinder/pages/shopping_page.dart';
import 'package:pet_tinder/user_auth/user_profile.dart';
import 'package:pet_tinder/utils/custom_texts.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_drawer.dart';
import 'package:pet_tinder/widgets/custom_fab.dart';
import 'package:pet_tinder/widgets/custom_logo_container.dart';
import 'package:pet_tinder/widgets/custom_icon_button.dart';
import 'package:pet_tinder/widgets/custom_text_button.dart';
import 'package:pet_tinder/widgets/custom_text_widget.dart';

class WidgetTest extends StatefulWidget {
  const WidgetTest({Key? key}) : super(key: key);

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  var _bottomNavIndex = 0;
  final PageController _pageController = PageController();
  var _firebaseAuth = FirebaseAuth.instance;
  var appBarText = "Pet Tinder";
  bool fabActive = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ${user.email}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText, style: CustomTextStyle.appBarTextStyle),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          BlogPage(),
          ShoppingPage(),
          UserProfile(),
        ],
      ),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _customBottomNavBar(context),
    );
  }

  FloatingActionButton _basketfloatActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(
        Icons.shopping_basket,
        color: CustomColors.bottomNavBarColor,
        size: 30,
      ),
      backgroundColor: CustomColors.typeCardColor,
    );
  }

  AnimatedBottomNavigationBar _customBottomNavBar(BuildContext context) {
    return AnimatedBottomNavigationBar(
      activeColor: CustomColors.enabledColor,
      inactiveColor: Colors.white,
      backgroundColor: CustomColors.bottomNavBarColor,
      height: MediaQuery.of(context).size.height * .10,
      icons: [
        CupertinoIcons.home,
        CupertinoIcons.eyeglasses,
        Icons.shopping_cart,
        CupertinoIcons.person
      ],
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) {
        setState(() {
          _bottomNavIndex = index;
          _pageController.jumpToPage(index);
        });
      },
      //other params
    );
  }

  BottomNavigationBarItem customNavBarItem(String title, IconData iconData) =>
      BottomNavigationBarItem(
        label: title,
        backgroundColor: Colors.red,
        icon: Icon(iconData),
      );
}
