import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_tinder/pages/home_page.dart';
import 'package:pet_tinder/pages/shopping_page.dart';
import 'package:pet_tinder/user_auth/user_profile.dart';
import 'package:pet_tinder/utils/custom_texts.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
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
  var _firebaseAuth = FirebaseAuth.instance;
  final PageController _pageController = PageController();
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
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Image.network(
                  ImageUrls.loginPageLogoBckUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CustomTextButton(
              buttonText: "Blog",
              onPressed: () => Get.offNamed("/blogPage"),
            ),
            CustomTextButton(
              buttonText: "Hakkımızda",
              onPressed: () {},
            ),
            CustomTextButton(
              buttonText: "Bize Ulaşın",
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          HomePage(),
          ShoppingPage(),
          UserProfile(),
        ],
      ),
      floatingActionButton: _customfloatActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _customBottomNavBar(context),
    );
  }

  FloatingActionButton _customfloatActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: (() => Navigator.pushNamed(context, "/addNewPost")),
      child: Icon(
        CupertinoIcons.add,
        color: CustomColors.bottomNavBarColor,
        size: 30,
      ),
      backgroundColor: CustomColors.typeCardColor,
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
        CupertinoIcons.chat_bubble_2,
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