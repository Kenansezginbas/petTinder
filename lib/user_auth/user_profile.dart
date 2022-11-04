import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_tinder/state_management/user_contoller.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: profilePic(),
          height: height * .35,
          width: width,
          decoration: BoxDecoration(
            color: CustomColors.customOrangeColor,
            borderRadius: BorderRadiusDirectional.vertical(
              bottom: Radius.circular(60),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            var signOut = await fireaseAuth.signOut();
            Navigator.pushNamed(context, "/initialPage");
          },
          child: Text(
            "Logout",
            style: CustomTextStyle.buttonBlackTextStyle,
          ),
        ),
      ],
    ));
  }

  Stack profilePic() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            child: CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.transparent,
              foregroundColor: CustomColors.turquoiseColor,
              child: CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12.0,
                    child: Icon(
                      Icons.camera_alt,
                      size: 15.0,
                      color: CustomColors.blackIconColor,
                    ),
                  ),
                ),
                radius: 38.0,
                backgroundImage: NetworkImage(
                  ImageUrls.loginPageLogoUrl,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// TextButton(
//           onPressed: () async {
//             var signOut = await fireaseAuth.signOut();
//             Navigator.pushNamed(context, "/initialPage");
//           },
//           child: Text("Logout"),
//         ),
