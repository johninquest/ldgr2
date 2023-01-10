import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ldgr2/pages/home.dart';
import 'package:ldgr2/shared/snackbar_messages.dart';

import 'package:ldgr2/utils/router.dart';

class FirebaseAuthService {
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  emailSignIn(
      String userEmail, String userPassword, BuildContext context) async {
    try {
      UserCredential authUser = await fbAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      /*  log('AuthObj => $authUser');
      log('AuthObj => ${authUser.runtimeType}');
      log('Auth user => ${authUser.user.runtimeType}'); */
      if (authUser.runtimeType == UserCredential) {
        PageRouter().navigateToPage(HomePage(), context);
      }
      return authUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('User not found');
        return SnackBarMessage().customErrorMessage('User not found!', context);
        // return null;
      } else if (e.code == 'wrong-password') {
        // print('Wrong password');
        return SnackBarMessage().customErrorMessage('Wrong password!', context);
        // return null;
      } else if (e.code == 'invalid-email') {
        // print('Invalid email');
        return SnackBarMessage().customErrorMessage('Invalid email!', context);
        // return null;
      }
    }
  }

  facebookSignIn() {}
  googleSignIn() {}

  logoutUser() async {
    await fbAuth.signOut();
  }

  checkAuthStatus() {
    fbAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User has not been authenticated!');
      } else {
        print('User has been authenticated!');
      }
    });
  }

  getFbUser() {
    final fbUser = fbAuth.currentUser;
    // final fbUid = fbUser.uid;
    print('Current firebase auth =>  $fbAuth');
    print('Current firebase user =>  $fbUser');
    // print('Current firebase uid =>  $fbUid');
  }
}
