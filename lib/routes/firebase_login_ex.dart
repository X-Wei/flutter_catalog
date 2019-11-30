import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

final kFirebaseAnalytics = FirebaseAnalytics();

// NOTE: to add firebase support, first go to firebase console, generate the
// firebase json file, and add configuration lines in the gradle files.
// C.f. this commit: https://github.com/X-Wei/flutter_catalog/commit/48792cbc0de62fc47e0e9ba2cd3718117f4d73d1.
class FirebaseLoginExample extends StatefulWidget {
  const FirebaseLoginExample({Key key}) : super(key: key);

  @override
  _FirebaseLoginExampleState createState() => _FirebaseLoginExampleState();
}

class _FirebaseLoginExampleState extends State<FirebaseLoginExample> {
  FirebaseUser _user;
  // If this._busy=true, the buttons are not clickable. This is to avoid
  // clicking buttons while a previous onTap function is not finished.
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(
          (user) => setState(() => this._user = user),
        );
  }

  @override
  Widget build(BuildContext context) {
    final statusText = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(_user == null
          ? 'You are not logged in.'
          : 'You are logged in as "${_user.displayName}".'),
    );
    final googleLoginBtn = MaterialButton(
      color: Colors.blueAccent,
      child: Text('Log in with Google'),
      onPressed: this._busy
          ? null
          : () async {
              setState(() => this._busy = true);
              final user = await this._googleSignIn();
              this._showUserProfilePage(user);
              setState(() => this._busy = false);
            },
    );
    final anonymousLoginBtn = MaterialButton(
      color: Colors.deepOrange,
      child: Text('Log in anonymously'),
      onPressed: this._busy
          ? null
          : () async {
              setState(() => this._busy = true);
              final user = await this._anonymousSignIn();
              this._showUserProfilePage(user);
              setState(() => this._busy = false);
            },
    );
    final signOutBtn = FlatButton(
      child: Text('Log out'),
      onPressed: this._busy
          ? null
          : () async {
              setState(() => this._busy = true);
              await this._signOut();
              setState(() => this._busy = false);
            },
    );
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
        children: <Widget>[
          statusText,
          googleLoginBtn,
          anonymousLoginBtn,
          signOutBtn,
        ],
      ),
    );
  }

  // Sign in with Google.
  Future<FirebaseUser> _googleSignIn() async {
    final curUser = this._user ?? await FirebaseAuth.instance.currentUser();
    if (curUser != null && !curUser.isAnonymous) {
      return curUser;
    }
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
    final user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    kFirebaseAnalytics.logLogin();
    setState(() => this._user = user);
    return user;
  }

  // Sign in Anonymously.
  Future<FirebaseUser> _anonymousSignIn() async {
    final curUser = this._user ?? await FirebaseAuth.instance.currentUser();
    if (curUser != null && curUser.isAnonymous) {
      return curUser;
    }
    FirebaseAuth.instance.signOut();
    final anonyUser = (await FirebaseAuth.instance.signInAnonymously()).user;
    final userInfo = UserUpdateInfo();
    userInfo.displayName = '${anonyUser.uid.substring(0, 5)}_Guest';
    await anonyUser.updateProfile(userInfo);
    await anonyUser.reload();
    // Have to re-call `currentUser()` to make `updateProfile` work.
    // Cf. https://stackoverflow.com/questions/50986191/flutter-firebase-auth-updateprofile-method-is-not-working.
    final user = await FirebaseAuth.instance.currentUser();
    kFirebaseAnalytics.logLogin();
    setState(() => this._user = user);
    return user;
  }

  Future<Null> _signOut() async {
    final user = await FirebaseAuth.instance.currentUser();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(user == null
            ? 'No user logged in.'
            : '"${user.displayName}" logged out.'),
      ),
    );
    FirebaseAuth.instance.signOut();
    setState(() => this._user = null);
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
                title: Text('Last sign in: ${user.metadata.lastSignInTime}'),
              ),
              ListTile(
                title: Text('Creation time: ${user.metadata.creationTime}'),
              ),
              ListTile(title: Text('ProviderData: ${user.providerData}')),
            ],
          ),
        ),
      ),
    );
  }
}
