import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trim/modules/auth/repositries/authentications.dart';

class SocialAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            icon: Image.asset(facebookImagePath),
            onPressed: 1 == 0
                ? () {}
                : () async {
                    await Authenitcations.signInWithFacebook(context);
                    return;
                    await AuthCubit.getInstance(context).loginFacebook(context);
                  }),
        FutureBuilder(
          future: Authenitcations.initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              print('Error on future builder');
            else if (snapshot.connectionState == ConnectionState.done)
              return IconButton(
                  icon: Image.asset(googleImagePath),
                  onPressed: 1 == 0
                      ? () {}
                      : () async {
                          final user =
                              await Authenitcations.signInWithGoogle(context);
                          print('User is ' + user.toString());
                          return;
                          // final a = await GoogleSignInApi.login();
                          // print(GoogleSignInApi._googleSignIn.clientId);

                          // print(a.toString());
                          // return;
                          final res = GoogleSignIn(
                            scopes: [
                              'profile',
                              'https://www.googleapis.com/auth/userinfo.profile',
                              'https://www.googleapis.com/auth/gmail.readonly',
                            ],
                          );
                          if (await res.isSignedIn()) {
                            print(res.currentUser);
                            print('Signed in');
                          } else {
                            print('Not signed in');
                            // await res.signOut();
                            final signInUser = await res.signIn();
                            if (signInUser == null)
                              print('null');
                            else
                              print(signInUser.email);
                          }
                        });
            return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
              Colors.orange,
            ));
          },
        ),
      ],
    );
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount> login() async {
    print("HELLO");
    if (await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();
    return _googleSignIn.signIn();
  }
}
