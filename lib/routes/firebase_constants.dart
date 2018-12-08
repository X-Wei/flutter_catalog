import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

// For gathering user data.
final kFirebaseAnalytics = FirebaseAnalytics();
// For firebase authentication.
final kFirebaseAuth = FirebaseAuth.instance;
// Google sign-in configuration.
final kGoogleSignIn = GoogleSignIn();
// A reference to the firebase realtime database.
final kFirebaseDbRef = FirebaseDatabase.instance.reference();
// A reference for uploading files to firebase storage.
final kFirebaseStorageRef = FirebaseStorage.instance.ref();

// Animation duration for sending message.
const kAnimationDuration = 700;
// Route name of the login screen.
const kLoginScreenRouteName = 'LoginScreen';
