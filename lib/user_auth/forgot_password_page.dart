import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_tinder/utils/custom_input_decoration.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/widgets/custom_text_button.dart';
import 'package:pet_tinder/widgets/custom_text_widget.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var email;
  final formKey = GlobalKey<FormState>();
  var title = "Şifremi Unuttum";
  // FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
              sendPasswordLink(),
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
        ),
      );

  CustomTextButton sendPasswordLink() {
    return CustomTextButton(
      buttonText: "Bağlantı Sıfırlama Linki Gönder",
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          try {
            final credential = await FirebaseAuth.instance
                .sendPasswordResetEmail(email: email);
            debugPrint("Giriş Başarılı");
            //_userListenController.userEmail.value = email;
            Get.toNamed("/userAdressPage");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
              customShowDialog("Kullanıcı Bulunamadı");
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
              customShowDialog("Hatalı Mail veya Şifre Bilgisi");
            }
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
