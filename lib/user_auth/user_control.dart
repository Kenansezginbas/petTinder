import 'package:firebase_auth/firebase_auth.dart';

class UserControl {
  listenUser() {
    User? user;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        user = user;
        print('User is signed in! ${user.email}');
      }
    });
    return user;
  }
}
