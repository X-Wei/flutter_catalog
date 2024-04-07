import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';

/// ! We use riverpod to watch the login state change, and rebuild screen.
/// ! For more details see the riverpod example.
final currentUserStreamProvider =
    StreamProvider<User?>((ref) => FirebaseAuth.instance.authStateChanges());

final currentUserProvider = StateProvider<User?>((ref) {
  return ref.watch(currentUserStreamProvider).maybeWhen(
        data: (user) => user,
        orElse: () => null,
      );
});

class FlutterFireLoginUiExample extends ConsumerWidget {
  const FlutterFireLoginUiExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserStreamProvider).when(
          data: (user) =>
              user == null ? _buildLoginScreen() : _buildProfileScreen(),
          error: (e, _) => Text(e.toString()),
          loading: () => LinearProgressIndicator(),
        );
  }

  Widget _buildLoginScreen() {
    /// This SignInScreen comes from FlutterFire UI package.
    return SignInScreen(
      headerBuilder: (_, __, ___) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: kAppIcon,
      ),
      // ! Currently there's no providerConfig for Anonymous sign in, so we
      // add a btn ourselves.
      footerBuilder: (context, _) {
        return ElevatedButton.icon(
          icon: Icon(CommunityMaterialIcons.incognito),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
          label: const Text('Log in anonymously'),
          onPressed: FirebaseAuth.instance.signInAnonymously,
        );
      },
    );
  }

  Widget _buildProfileScreen() {
    return ProfileScreen(
      children: const [
        Text(
            '🚀We could add more content to the profile screen via the `children` param.')
      ],
    );
  }
}
