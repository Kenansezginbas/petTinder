import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_tinder/pages/about_us.dart';
import 'package:pet_tinder/pages/add_new_post.dart';
import 'package:pet_tinder/pages/blog_page.dart';
import 'package:pet_tinder/pages/contact_us.dart';
import 'package:pet_tinder/pages/post_report_page.dart';
import 'package:pet_tinder/pages/shopping_page.dart';
import 'package:pet_tinder/user_auth/forgot_password_page.dart';
import 'package:pet_tinder/user_auth/initial_page.dart';
import 'package:pet_tinder/user_auth/login_page.dart';
import 'package:pet_tinder/user_auth/landing_page.dart';
import 'package:pet_tinder/user_auth/sign_up.dart';
import 'package:pet_tinder/user_auth/user_profile.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/widget_test.dart';
import 'firebase_options.dart';
// Import the generated file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Tinder',
      routes: {
        "/landingPage": (context) => LandingPage(),
        "/loginPage": (context) => LoginPage(),
        "/signUp": (context) => SignUp(),
        "/forgotPassword": (context) => ForgotPasswordPage(),
        "/userProfile": (context) => UserProfile(),
        "/addNewPost": (context) => AddNewPost(),
        "/blogPage": (context) => BlogPage(),
        "/postReportPage": (context) => PostReportPage(),
        "/initialPage": (context) => InitialPage(),
        "/shoppingPage": (context) => ShoppingPage(),
        "/aboutUS": (context) => AboutUS(),
        "/contactUS": (context) => ContactUS(),
        "/widgetTest": (context) => WidgetTest()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
            backgroundColor: CustomColors.bottomNavBarColor,
            iconTheme: IconThemeData(
              color: CustomColors.turquoiseColor,
            )),
      ),
      home: LandingPage(),
    );
  }
}
