import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pet_tinder/models/post_model.dart';
import 'package:pet_tinder/pages/blog_page_detail.dart';
import 'package:pet_tinder/user_auth/user_control.dart';
import 'package:pet_tinder/utils/custom_text_styles.dart';
import 'package:pet_tinder/utils/image_urls.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';
import 'package:pet_tinder/widgets/custom_logo_container.dart';
import 'package:pet_tinder/widgets/custom_post_container.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final blogRef = FirebaseFirestore.instance.collection("Blog");
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
        stream: blogRef.snapshots(),
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
            itemCount: 2,
            itemBuilder: (context, index) {
              return blogItem(
                  data.docs[index]["BlogTitle"],
                  data.docs[index]["BlogTitle"],
                  data.docs[index]["ImageURL"],
                  data.docs[index]["URL"]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: .7),
          );
        },
      ),
    );
  }

  Widget blogItem(String title, String user, String imageURL, String url) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogPageDetail(
                url: url,
              ),
            ),
          );
        },
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  maxLines: 2,
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.titleTextStyle,
                ),
              ),
              ClipRRect(
                child: Image(
                  height: MediaQuery.of(context).size.height * .20,
                  width: MediaQuery.of(context).size.width * .40,
                  image: NetworkImage(imageURL),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            ],
          ),
        ),
      );
}
