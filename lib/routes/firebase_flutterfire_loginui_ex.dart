import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/auth.dart';

import '../constants.dart';

/// ! We use riverpod to watch the login state change, and rebuild screen.
/// ! For more details see the riverpod example.
final currentUserProvider =
    StreamProvider<User?>((ref) => FirebaseAuth.instance.authStateChanges());

final _kLoginProviderConfigs = [
  GoogleProviderConfiguration(
    //! The clientId is copied from the app's Firebase console.
    clientId:
        '785184947614-k4q21aq3rmasodkrj5gjs9qtqtkp89tt.apps.googleusercontent.com',
  ),
  EmailProviderConfiguration(),
];

class FlutterFireLoginUiExample extends ConsumerWidget {
  const FlutterFireLoginUiExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
          data: (user) =>
              user == null ? _buildLoginScreen() : _buildProfileScreen(),
          error: (e, _) => Text(e.toString()),
          loading: () => LinearProgressIndicator(),
        );
  }

  Widget _buildLoginScreen() {
    return SignInScreen(
      providerConfigs: _kLoginProviderConfigs,
      headerBuilder: (_, __, ___) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: kAppIcon,
      ),
      footerBuilder: (context, _) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'By signing in, you agree to our terms and conditions.',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }

  Widget _buildProfileScreen() {
    return ProfileScreen(
      providerConfigs: _kLoginProviderConfigs,
      children: const [
        Text(
            '🚀We could add more content to the profile screen via the `children` param.')
      ],
    );
  }
}
