import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_tinder/models/post_model.dart';
import 'package:pet_tinder/pages/post_report_page.dart';
import 'package:pet_tinder/service/firebase_methods.dart';
import 'package:pet_tinder/user_auth/user_control.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
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
  var firebaseMethods = FirebaseMethods();
  late bool like;
  final postRef =
      FirebaseFirestore.instance.collection("Posts").orderBy("PostDate");
  final _firebaseFirestore = FirebaseFirestore.instance.collection("Posts");
  final fireaseAuth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  var userEmail;
  var listUser;
  var img;
  late User listenUser;
  //var resultimg = FirebaseStorage.instance.ref().child(_img).getDownloadURL();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in! ${user.email}');
          userEmail = user.email;
          listUser = user;
          listenUser = user;
        }
      },
    );
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
              //   print("data" + data.docs[index].reference.id.toString());
              List likeList = data.docs[index]["Like"];
              // print(likeList);
              // // print("list ${likeList[index]}");
              // if (likeList.contains(userEmail)) {
              //   print(likeList.contains(userEmail));
              //   print("Like");
              // } else {
              //   print("No Like");
              // }
              print("id ?::::: " + data.docs[index].reference.id.toString());
              return postItem(
                data.docs[index]["PostDesc"],
                data.docs[index]["ImageURL"],
                data.docs[index]["User"].substring(
                  0,
                  data.docs[index]["User"].indexOf("@"),
                ),
                data.docs[index].reference.id.toString(),
                data.docs[index].reference.id,
                likeList.contains(userEmail) == true
                    ? Icon(Icons.favorite_rounded, color: Colors.red)
                    : Icon(Icons.favorite_border),
                likeList.contains(userEmail),
                likeList,
              );
            },
          );
        },
      ),
    );
  }

  Widget postItem(String postDesc, String imageURL, String user, String postID,
          doc, Icon icon, bool isLiked, List likes) =>
      Column(
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
                      color: CustomColors.turquoiseColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: img == null
                          ? Center(
                              child: Text(
                                (user[0].toUpperCase()),
                                style: CustomTextStyle.buttonBlackTextStyle,
                              ),
                            )
                          : Image(
                              image: NetworkImage(
                                FirebaseStorage.instance
                                    .ref()
                                    .child("profileImage/" +
                                        user +
                                        "@gmail.com.png")
                                    .getDownloadURL()
                                    .toString(),
                              ),
                            ),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostReportPage(
                            postID: postID,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.more_horiz))
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
                IconButton(
                  onPressed: () async {
                    setState(() {
                      firebaseMethods.likePost(
                          user: listenUser,
                          postId: postID,
                          uid: listenUser.uid,
                          likes: likes);
                    });
                  },
                  icon: icon,
                ),
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

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    print("sjfhjshfsf");

    return !isLiked;
  }

  likeAction(doc, bool isLiked) {
    //print("Like Action Calisti");
    _firebaseFirestore.doc(doc).update({
      "Like": FieldValue.arrayUnion([userEmail])
    }).then((value) {
      //  print("kjhgjsdkhgfdg");
    });
    //  print("Like Action Bitti");

    // if (isLiked == false) {
    //   _firebaseFirestore.doc(doc).update({
    //     "Like": FieldValue.arrayUnion([userEmail])
    //   });
    // } else {
    //   //  _firebaseFirestore.doc(doc).set({
    //   //     "Like": FieldValue.delete([userEmail])
    //   //   });
    // }
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(listenUser.email)) {
        // if the likes list contains the user uid, we need to remove it
        _firebaseFirestore.doc(postId).update({
          'Like': FieldValue.arrayRemove([listenUser.email])
        });
      } else {
        // else we need to add uid to the likes array
        _firebaseFirestore.doc(postId).update({
          'Like': FieldValue.arrayUnion([listenUser.email])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
