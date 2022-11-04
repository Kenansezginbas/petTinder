import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_tinder/service/firebase_methods.dart';
import 'package:pet_tinder/utils/custom_func.dart';
import 'package:pet_tinder/utils/custom_input_decoration.dart';
import 'package:pet_tinder/widgets/custom_elevated_button.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({super.key});

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  var firebaseMethods = FirebaseMethods();
  var customFuncs = CustomFuncs();
  final formKey = GlobalKey<FormState>();
  User? listenUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ${user.email}');
        listenUser = user;
      }
    });
  }

  var message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Bize Ulaşın", actions: []),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 3,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Lütfen Alanları Doldurunuz";
                  } else if (val.length <= 10) {
                    return "Daha Detaylı Anlatınız";
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  message = val!;
                },
                decoration: CustomInputDecoration.customInputDecorationDialog(
                    "Mesajınızı Yazınız"),
                cursorColor: Colors.black,
              ),
            ),
          ),
          CustomElevatedButton(
            buttonText: "Mesajı Gönder",
            onPressed: postContacts,
          )
        ],
      ),
    );
  }

  void postContacts() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      firebaseMethods.saveContacts(
          message: message, email: listenUser!.email, resultData: "");
      customFuncs.showSnackBar(context: context, message: message);
      formKey.currentState!.reset();
    }
  }
}
