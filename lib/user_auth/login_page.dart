import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_tinder/state_management/user_contoller.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/utils/custom_input_decoration.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/widgets/custom_elevated_button.dart';
import 'package:pet_tinder/widgets/custom_text_button.dart';
import 'package:pet_tinder/widgets/custom_text_widget.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email, password;
  final formKey = GlobalKey<FormState>();
  var title = "Giriş Yap";
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: CustomTextStyle.authTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                textFormFieldEmail(),
                SizedBox(height: 20),
                textFormFieldPassword(),
                SizedBox(height: 10),
                loginButton(),
                forgotPasswordButton(context),
                signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormFieldEmail() => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Lütfen Alanları Doldurunuz";
          } else {
            return null;
          }
        },
        onSaved: (val) {
          email = val!.trim();
        },
        decoration: CustomInputDecoration.customInputDecoration("Email"),
        cursorColor: Colors.black,
      );
  Widget textFormFieldPassword() => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Lütfen Alanları Doldurunuz";
          } else {
            return null;
          }
        },
        onSaved: (val) {
          password = val!.trim();
        },
        decoration: CustomInputDecoration.customInputDecoration("Şifre"),
        cursorColor: Colors.black,
        obscureText: true,
      );
  CustomElevatedButton loginButton() {
    return CustomElevatedButton(
      buttonText: "Giriş",
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          firebaseLogin();
          debugPrint(email);
        } else {}
      },
    );
  }

  CustomTextButton forgotPasswordButton(BuildContext context) {
    return CustomTextButton(
      buttonText: "Şifremi Unuttum",
      onPressed: () => Navigator.pushNamed(context, "/forgotPassword"),
    );
  }

  CustomTextButton signUpButton() {
    return CustomTextButton(
      buttonText: "Kayıt Ol",
      onPressed: () => Navigator.pushNamed(context, "/signUp"),
    );
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
        customShowDialog("Kullanıcı Bulunamadı");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        customShowDialog("Hatalı Mail veya Şifre Bilgisi");
      }
    }
  }

  Future customShowDialog(String errorMessage) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              "Hata",
              style: CustomTextStyle.titleTextStyle,
            ),
            content: Text(
              errorMessage,
              style: CustomTextStyle.titleTextStyle,
            ),
            actions: [
              CustomTextButton(
                buttonText: "Geri Dön",
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}
