import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import '../my_route.dart';

final kFirebaseAuth = FirebaseAuth.instance;
final kGoogleSignIn = GoogleSignIn();

// NOTE: to add firebase support, first go to firebase console, generate the
// firebase json file, and add configuration lines in the gradle files.
// C.f. this commit: https://github.com/X-Wei/flutter_catalog/commit/48792cbc0de62fc47e0e9ba2cd3718117f4d73d1.
class FirebaseLoginExample extends MyRoute {
  const FirebaseLoginExample(
      [String sourceFile = 'lib/routes/firebase_login_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Firebase login';

  @override
  get description => 'Google/Anonymous sign in';

  @override
  get links => {
        'Youtube video': 'https://www.youtube.com/watch?v=JYCNvWKF7vw',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final googleLoginBtn = MaterialButton(
      color: Colors.blueAccent,
      child: Text('Log in with Google'),
      onPressed: () {
        this._googleSignIn()
          ..then(this._showUserProfilePage)
          ..catchError((e) => print(e));
      },
    );
    final anonymousLoginBtn = MaterialButton(
      color: Colors.deepOrange,
      child: Text('log in anonymously'),
      onPressed: () {
        this._anonymousSignIn()
          ..then(this._showUserProfilePage)
          ..catchError((e) => print(e));
      },
    );
    final signOutBtn = FlatButton(
      child: Text('Log out'),
      onPressed: () => this._signOut(),
    );
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
        children: <Widget>[
          googleLoginBtn,
          anonymousLoginBtn,
          signOutBtn,
        ],
      ),
    );
  }

  // Sign in with Google.
  Future<FirebaseUser> _googleSignIn() async {
    final curUser = await kFirebaseAuth.currentUser();
    if (curUser != null && !curUser.isAnonymous) {
      return curUser;
    }
    final googleUser = await kGoogleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final user = await kFirebaseAuth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
    return user;
  }

  // Sign in Anonymously.
  Future<FirebaseUser> _anonymousSignIn() async {
    final curUser = await kFirebaseAuth.currentUser();
    if (curUser != null && curUser.isAnonymous) {
      return curUser;
    }
    kFirebaseAuth.signOut();
    final anonyUser = await kFirebaseAuth.signInAnonymously(); // final
    final userInfo = UserUpdateInfo();
    userInfo.displayName = '${anonyUser.uid.substring(0, 5)}_Guest';
    // Have to re-call kFirebaseAuth.currentUser() to make `updateProfile` work.
    // C.f. https://stackoverflow.com/questions/50986191/flutter-firebase-auth-updateprofile-method-is-not-working.
    await anonyUser.updateProfile(userInfo);
    await anonyUser.reload();
    final user = await kFirebaseAuth.currentUser();
    return user;
  }

  Future<Null> _signOut() async {
    final user = await kFirebaseAuth.currentUser();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(user == null
            ? 'No user logged in.'
            : '"${user.displayName}" logged out.'),
      ),
    );
    kFirebaseAuth.signOut();
  }

  // Show user's profile in a new screen.
  void _showUserProfilePage(FirebaseUser user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
              appBar: AppBar(
                title: Text('user profile'),
              ),
              body: ListView(
                children: <Widget>[
                  ListTile(title: Text('User id: ${user.uid}')),
                  ListTile(title: Text('Display name: ${user.displayName}')),
                  ListTile(title: Text('Anonymous: ${user.isAnonymous}')),
                  ListTile(title: Text('providerId: ${user.providerId}')),
                  ListTile(title: Text('Email: ${user.email}')),
                  ListTile(
                    title: Text('Profile photo: '),
                    trailing: user.photoUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user.photoUrl),
                          )
                        : CircleAvatar(
                            child: Text(user.displayName[0]),
                          ),
                  ),
                  ListTile(
                    title: Text(
                        'Last sign in: ${DateTime.fromMillisecondsSinceEpoch(user.metadata.lastSignInTimestamp)}'),
                  ),
                  ListTile(
                    title: Text(
                        'Creation time: ${DateTime.fromMillisecondsSinceEpoch(user.metadata.creationTimestamp)}'),
                  ),
                  ListTile(title: Text('ProviderData: ${user.providerData}')),
                ],
              ),
            ),
      ),
    );
  }
}
