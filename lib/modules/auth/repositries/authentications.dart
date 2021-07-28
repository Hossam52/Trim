import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/social_profile_model.dart';

class Authenitcations {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<SocialProfileModel> signInWithGoogle(
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
      return SocialProfileModel(
          user: user, token: googleSignInAuthentication.accessToken);
    }
    return null;
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (await GoogleSignIn().isSignedIn()) {
        print('logout google');
        await GoogleSignIn().signOut();
      }
      if (await FacebookLogin().isLoggedIn) {
        print('logout facebook');
        await FacebookLogin().logOut();
      }
    } catch (e) {
      print('Error singing out');
    }
  }

  static Future<SocialProfileModel> signInWithFacebook(
      BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final facebookLogin = FacebookLogin();
    final res = await facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        print(res.accessToken);
        final cred = FacebookAuthProvider.credential(res.accessToken.token);
        final profile = await auth.signInWithCredential(cred);
        final user = profile.user;
        final phototUrl =
            await FacebookLogin().getProfileImageUrl(width: 400, height: 400);
        print(phototUrl);
        print(user);
        print('Success logging with facebook');
        return SocialProfileModel(
            user: user, photoUrl: phototUrl, token: res.accessToken.token);
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
