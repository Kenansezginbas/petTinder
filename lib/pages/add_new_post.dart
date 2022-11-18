import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_tinder/utils/custom_input_decoration.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_elevated_button.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';
import 'package:uuid/uuid.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({super.key});

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  File? image;
  String postDesc = "";
  bool isLoading = false;
  final _firebaseFirestore = FirebaseFirestore.instance.collection("Posts");
  final _cloudStroage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  late var id;
  var _firebaseAuth = FirebaseAuth.instance;
  var userEmail;
  var now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ${user.email}');
        userEmail = user.email;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: "Yeni Gönderi",
        actions: [
          // IconButton(
          //   onPressed: pickImage,
          //   icon: Icon(Icons.camera_alt),
          // )
        ],
      ),
      body: isLoading ? showProgress() : postImage(),
    );
  }

  Center showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  postImage() => Column(children: [
        Container(
          child: image == null
              ? Container(
                  height: MediaQuery.of(context).size.height * .35,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(ImageUrls.loginPageLogoUrl),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Lütfen Foto Yükleyiniz",
                              style: CustomTextStyle.headline3),
                          Icon(
                            Icons.camera_alt,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.height * .35,
                      width: MediaQuery.of(context).size.width,
                      image: FileImage(image!),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLines: 3,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Lütfen Alanları Doldurunuz";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            postDesc = val!;
                          },
                          decoration:
                              CustomInputDecoration.customInputDecorationDialog(
                                  "Açıklama"),
                          cursorColor: Colors.black,
                        ),
                      ),
                    ),
                    CustomElevatedButton(
                      buttonText: "Paylaş",
                      onPressed: saveImage,
                    ),
                  ],
                ),
        ),
      ]);

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  savePost(imageURL) async {
    try {
      final result = await _firebaseFirestore.add({
        "ImageURL": imageURL,
        "PostDesc": postDesc,
        "User": userEmail,
        "PostID": uuid.v1(),
        "PostDate": now.toString(),
        "Like": []
      });
      cleanData();
      showSnackBar("Gönderi Paylaşıldı");
    } catch (e) {
      print(e.toString());

      showSnackBar(e.toString());
    }
  }

  saveImage() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      id = uuid.v1();
      try {
        final result = await _cloudStroage
            .ref("post")
            .child(id.toString())
            .putFile(image!);
        var url = await result.ref.getDownloadURL();
        savePost(url);
      } catch (e) {
        print(e.toString());
      }
    }
  }

//veri kaydedildiğinde değişkenleri null'a çeker, loadingi false yapar;
  cleanData() {
    setState(() {
      image = null;
      postDesc = "";
      isLoading = false;
    });
  }

  showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
