import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_tinder/state_management/user_contoller.dart';
import 'package:pet_tinder/widgets/custom_text_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final UserController userController = Get.put(UserController());
  final _cloudStroage = FirebaseStorage.instance;
  bool isLoading = false;

  final fireaseAuth = FirebaseAuth.instance;
  User? listenUser;
  var userPhotoURL;
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      saveImage();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  saveImage() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await _cloudStroage
          .ref("post")
          .child(listenUser!.email!)
          .putFile(image!);
      var url = await result.ref.getDownloadURL();
      var newImage = await listenUser!.updatePhotoURL(url);
    } catch (e) {
      print(e.toString());
    }
  }

  userListen() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ${user.email}');
        listenUser = await user;
        userPhotoURL = user.photoURL;
        print("photo url : $userPhotoURL");
        //print("url $listenUser");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userListen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text("f")
      ),
    );
  }
}
