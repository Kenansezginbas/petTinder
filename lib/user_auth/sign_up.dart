import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_tinder/database/database_helper.dart';
import 'package:pet_tinder/service/firebase_methods.dart';
import 'package:pet_tinder/utils/custom_dialog.dart';
import 'package:pet_tinder/utils/custom_input_decoration.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/widgets/custom_elevated_button.dart';
import 'package:pet_tinder/widgets/custom_text_button.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email, password, passwordAgain;
  final formKey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  var title = "Üye Ol";
  // FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var databaseHelper = DatabaseHelper.instance;
  final customDialog = CustomDialog();
  final firebaseMethods = FirebaseMethods();
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
                SizedBox(height: 20),
                textFormFieldPasswordAgain(),
                SizedBox(height: 20),
                signUpButton(),
                SizedBox(height: 10),
                CustomTextButton(
                  buttonText: "Giriş Ekranına Dön",
                  onPressed: () => Get.offNamed("/loginPage"),
                )
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
        keyboardType: TextInputType.emailAddress,
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
  Widget textFormFieldPasswordAgain() => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Lütfen Alanları Doldurunuz";
          } else {
            return null;
          }
        },
        onSaved: (val) {
          passwordAgain = val!.trim();
        },
        decoration:
            CustomInputDecoration.customInputDecoration("Şifre (Tekrar)"),
        cursorColor: Colors.black,
        obscureText: true,
      );
  CustomElevatedButton signUpButton() {
    return CustomElevatedButton(
      buttonText: "Kayıt",
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          if (password == passwordAgain) {
            customDialog.showProgress(context);
            firebaseMethods.signUp(context, email, password);
          } else {
            customShowDialog("Şifreler Uyuşmuyor");
          }
          debugPrint(email);
        } else {}
      },
    );
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
