import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/google_auth_model.dart';

class Authenitcations {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<GoogleProfileModel> signInWithGoogle(
      BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print('Access Token  ' + googleSignInAuthentication.accessToken);
      print('Id Token  ' + googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          print('account-exists-with-different-credential');
        } else if (e.code == 'invalid-credential') {
          // handle the error here
          print('invalid creditioal');
        }
      } catch (e) {
        print('Error happened when sign in ' + e.toString());
        // handle the error here
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('signed in with ${user.displayName}')));
      return GoogleProfileModel(
          user: user, token: googleSignInAuthentication.idToken);
    }
    return null;
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error when sign out')));
      print('Error singing out');
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Successifully signed out')));
  }

  static Future<User> signInWithFacebook(BuildContext context) async {
    final facebookLogin = FacebookLogin();
    final res = await facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        print(res.accessToken);
        print('Success logging with facebook');
        break;
      case FacebookLoginStatus.cancel:
        print('cancel');
        break;
      case FacebookLoginStatus.error:
        print(res.error);
        break;
    }
    return null;
  }
}
