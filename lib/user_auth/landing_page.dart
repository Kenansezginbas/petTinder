import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_tinder/pages/home_page.dart';
import 'package:pet_tinder/user_auth/initial_page.dart';
import 'package:pet_tinder/widget_test.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userControl();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return InitialPage();
    } else {
      return WidgetTest();
    }
  }

  Future<void> userControl() async {
    user = await FirebaseAuth.instance.currentUser;
    setState(() {});
  }
}
