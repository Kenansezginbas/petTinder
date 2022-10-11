import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pet_tinder/models/post_model.dart';
import 'package:pet_tinder/user_auth/user_control.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_logo_container.dart';
import 'package:pet_tinder/widgets/custom_post_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final postRef = FirebaseFirestore.instance.collection("Posts");
  final fireaseAuth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  var userEmail;
  var listUser;
  var img;
  //var resultimg = FirebaseStorage.instance.ref().child(_img).getDownloadURL();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ${user.email}');
        userEmail = user.email;
        listUser = user;
      }
    });
    getimg();
  }

  getimg() async {
    final _img = "profileImage/kenansezginbas@hotmail.com" + ".png";
    img = await storage.ref().child(_img).getDownloadURL();
    print("URL" + img);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: postRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return postItem(
                data.docs[index]["PostDesc"],
                data.docs[index]["ImageURL"],
                data.docs[index]["User"].substring(
                  0,
                  data.docs[index]["User"].indexOf("@"),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget postItem(String postDesc, String imageURL, String user) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 4, top: 10),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: img == null
                          ? FlutterLogo()
                          : Image(
                              image: NetworkImage(FirebaseStorage.instance
                                  .ref()
                                  .child("profileImage/" + user + "@gmail.com.png")
                                  .getDownloadURL()
                                  .toString())),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  user,
                  style: CustomTextStyle.postUserTextStyle,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * .40,
            width: MediaQuery.of(context).size.width,
            child: CustomPostContainer(
              logoBckImage: ImageUrls.loginPageLogoBckUrl,
              logoCatImage: imageURL,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 4),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                IconButton(
                    onPressed: () {}, icon: Icon(CupertinoIcons.chat_bubble)),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Row(
              children: [
                Text(
                  user,
                  style: CustomTextStyle.postUserTextStyle,
                ),
                SizedBox(width: 5),
                Text(
                  postDesc,
                  style: CustomTextStyle.postDescTextStyle,
                ),
              ],
            ),
          ),
        ],
      );
}
