import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pet_tinder/models/post_model.dart';
import 'package:pet_tinder/user_auth/user_control.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_logo_container.dart';
import 'package:pet_tinder/widgets/custom_post_container.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final postRef = FirebaseFirestore.instance.collection("Posts");
  final fireaseAuth = FirebaseAuth.instance;
  var userEmail;
  var listUser;

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
          return GridView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return blogItem(
                  "title",
                  data.docs[index]["User"].substring(
                    0,
                    data.docs[index]["User"].indexOf("@"),
                  ),
                  "imageURL");
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: .7),
          );
        },
      ),
    );
  }

  Widget blogItem(String title, String user, String imageURL) => Container(
        child: Column(
          children: [
            Text(title),
            Container(
              height: 200,
              width: 200,
              child: FlutterLogo(),
            ),
            Text(title),
          ],
        ),
      );
}
