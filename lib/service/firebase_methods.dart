import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_tinder/utils/custom_dialog.dart';

class FirebaseMethods {
  final _firebaseFirestore = FirebaseFirestore.instance.collection("Posts");
  final firebaseAuth = FirebaseAuth.instance;
  final customDialog = CustomDialog();
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

  Future signUp(BuildContext context, String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      Navigator.pushNamed(context, "/widgetTest");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      switch (e.code) {
        case "email-already-in-use":
          customDialog.customShowDialog(
              context, "Kullanıcı Zaten Mevcut, Lütfen Giriş Yapınız.");
          break;
        case "weak-password":
          customDialog.customShowDialog(
              context, "Şifre Çok Kısa, En Az 6 Karakter Giriniz");
          break;
        case "invalid-email":
          customDialog.customShowDialog(
              context, "Mail Formatı Hatalı, Lütfen Mail Adresinizi Giriniz");
      }
    }
  }

  Future signIn(BuildContext context, String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.offNamed("/widgetTest");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        customDialog.customShowDialog(context, "Kullanıcı Bulunamadı");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        customDialog.customShowDialog(
            context, "Hatalı Mail veya Şifre Bilgisi");
      }
    }
  }
}
