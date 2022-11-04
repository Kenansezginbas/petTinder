import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethods {
  final _firebaseFirestore = FirebaseFirestore.instance.collection("Posts");
  Future<String> likePost({
    required User user,
    required String postId,
    required String uid,
    required List likes,
  }) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(user.email)) {
        // if the likes list contains the user uid, we need to remove it
        _firebaseFirestore.doc(postId).update({
          'Like': FieldValue.arrayRemove([user.email])
        });
      } else {
        // else we need to add uid to the likes array
        _firebaseFirestore.doc(postId).update({
          'Like': FieldValue.arrayUnion([user.email])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  savePostReport({postID, resultData, whoIsSendReport}) async {
    final _firebaseFirestore = FirebaseFirestore.instance.collection("Reports");
    try {
      final result = await _firebaseFirestore.add({
        "postID": postID,
        "result": resultData,
        "whoIsSendReport": whoIsSendReport,
      });
    } catch (e) {}
  }

  saveContacts({message, email, resultData}) async {
    final _firebaseFirestore =
        FirebaseFirestore.instance.collection("Contacts");
    try {
      final result = await _firebaseFirestore.add({
        "message": message,
        "email": email,
        "result": resultData,
      });
    } catch (e) {}
  }
}
