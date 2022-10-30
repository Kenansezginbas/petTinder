import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_tinder/database/database_helper.dart';
import 'package:pet_tinder/utils/custom_input_decoration.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/widgets/custom_text_button.dart';
import 'package:pet_tinder/widgets/custom_text_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              textFormFieldEmail(),
              textFormFieldPassword(),
              textFormFieldPasswordAgain(),
              signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormFieldEmail() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
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
        ),
      );
  Widget textFormFieldPassword() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
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
        ),
      );
  Widget textFormFieldPasswordAgain() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
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
        ),
      );
  CustomTextButton signUpButton() {
    return CustomTextButton(
      buttonText: "Kayıt Ol",
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          if (password == passwordAgain) {
            try {
              final credential =
                  await firebaseAuth.createUserWithEmailAndPassword(
                      email: email, password: password);
              customSnackBar();
              try {
                var databaseResult = await databaseHelper
                    .insert({"email": email, "password": password});
                print("database result" + databaseResult.toString());
              } catch (e) {}
              Navigator.pushNamed(context, "/widgetTest");
              //_userListenController.userEmail.value = email;
              //Get.toNamed("/userAdressPage");
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
                customShowDialog("Kullanıcı Bulunamadı");
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
                customShowDialog("Hatalı Mail veya Şifre Bilgisi");
              }
            }
          } else {
            customShowDialog("Şifreler Uyuşmuyor");
          }
          debugPrint(email);
        } else {}
      },
    );
  }

  void customSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Kayıt Başarılı, Anasayfaya yönlendiriliyorsunuz"),
      ),
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
