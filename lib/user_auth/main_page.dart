import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_tinder/database/database_helper.dart';
import 'package:pet_tinder/state_management/user_contoller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  query() async {
    var result = await databaseHelper.queryAllRows();
    print("Database Helper Calisti");
    print(result[0]["email"]);
    email = result[0]["email"];
    password = result[0]["password"];

    firebaseLogin();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query();
  }

  var email, password;
  final formKey = GlobalKey<FormState>();
  var title = "Giriş Yap";
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserController userController = Get.put(UserController());
  double widgetSpacing = 30;
  var databaseHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  firebaseLogin() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      userController.user.value = email;
      debugPrint("Giriş Başarılı");
      debugPrint(userController.user.value);
      //_userListenController.userEmail.value = email;
      Get.offNamed("/widgetTest");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.offNamed("/initialPage");

        // CustomDialog().customShowDialog(context, "Kullanıcı Bulunamadı");
      } else if (e.code == 'wrong-password') {
        Get.offNamed("/initialPage");

        print('Wrong password provided for that user.');
        // CustomDialog()
        //     .customShowDialog(context, "Hatalı Mail veya Şifre Bilgisi");
      }
    }
  }
}
