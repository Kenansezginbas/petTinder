import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_tinder/pages/blog_page.dart';
import 'package:pet_tinder/pages/home_page.dart';
import 'package:pet_tinder/pages/scr_page.dart';
import 'package:pet_tinder/pages/shopping_page.dart';
import 'package:pet_tinder/user_auth/user_profile.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';
import 'package:pet_tinder/widgets/custom_drawer.dart';
import 'package:pet_tinder/widgets/custom_fab.dart';

class WidgetTest extends StatefulWidget {
  const WidgetTest({Key? key}) : super(key: key);

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  var _bottomNavIndex = 0;
  final PageController _pageController = PageController();
  var _firebaseAuth = FirebaseAuth.instance;
  var appBarText = "Pet Takip";
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
      appBar: CustomAppBar(title: appBarText, actions: []),
      drawer: CustomDrawer(),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          BlogPage(),
          SCRPage(),
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
        Icons.history_edu_rounded,
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
