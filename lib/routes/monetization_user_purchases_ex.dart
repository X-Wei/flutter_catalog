// ignore_for_file: avoid_positional_boolean_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../my_app_settings.dart';
import 'firebase_flutterfire_loginui_ex.dart';

Widget buildUserBanner(BuildContext context, WidgetRef ref) {
  final user = ref.watch(currentUserProvider);
  final content = user != null
      ? ListTile(
          title: Text('You are logged in as "${user.displayName ?? user.uid}"'),
          subtitle: Text('Tap here to log in other accounts.'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.of(context)
              .pushNamed('/firebase_flutterfire_loginui_ex'),
        )
      : ListTile(
          title: Text('Go to login page'),
          subtitle:
              Text('Log in to sync your purchase/reward items across devices'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.of(context)
              .pushNamed('/firebase_flutterfire_loginui_ex'),
        );
  return Card(color: Colors.blue, child: content);
}

class UserPurchasesExample extends ConsumerWidget {
  const UserPurchasesExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        SizedBox(height: 4),
        MarkdownBody(data: _description, selectable: true),
        Divider(),
        buildUserBanner(context, ref),
        Divider(),
        if (user != null) ...[
          ListTile(title: Text('user id=${user.uid}')),
          ListTile(title: Text('💰 coins = ${ref.watch(userCoinsProvider)}')),
          ListTile(
              title: Text('ad_removed = ${ref.watch(adIsRemovedProvider)}')),
          if (kDebugMode) ...[
            ElevatedButton(
                onPressed: () => addCoins(ref, 1), child: Text('buy 1 coin')),
            ElevatedButton(
                onPressed: () => setRemoveAds(ref, true),
                child: Text('remove ads')),
            ElevatedButton(
                onPressed: () => setRemoveAds(ref, false),
                child: Text('unremove ads')),
          ],
        ],
      ],
    );
  }

  static const _description = '''

## Managing user-purchases
The IAP package just handles purchases, *we must manage the user-purchases in our 
own bussiness-logic*.

To do so, we use **firestore** document at **`/users/\$uid`** as source-of-truth.
And use **riverpod** to easily fetch it's state from other parts of the app.

***=> Please check the source code for how those riverpod providers are defined and composed.***
''';
}

Future<void> addCoins(WidgetRef ref, int n) async {
  // If not logged in: use local setting to add coins.
  if (ref.read(currentUserProvider) == null) {
    ref.read(mySettingsProvider).rewardCoins += n;
    return;
  }
  // Otherwise, set user's num_coins on Firestore.
  final userDoc = ref.read(userFirestoreDocRefProvider);
  await userDoc?.set({}, SetOptions(merge: true));
  final oldNum = ref.read(userCoinsProvider);
  await userDoc?.update({kNumCoinsKey: oldNum + n});
}

Future<void> setRemoveAds(WidgetRef ref, bool val) async {
  final userDoc = ref.read(userFirestoreDocRefProvider);
  await userDoc?.set({}, SetOptions(merge: true));
  await userDoc?.update({kUserAdRemovedKey: val});
}

// -----------------------------------------------------------------------------
// !======= below are riverpod logics for managing purchases state =========!
const kUserAdRemovedKey = 'adremove';
const kNumCoinsKey = 'coins';

/// ! Privde the Firestore doc (json) located in "/users/$uid".
final userFirestoreDocRefProvider =
    Provider.autoDispose<DocumentReference<Map<String, dynamic>>?>((ref) {
  final auth = ref.watch(currentUserStreamProvider);
  if (auth.asData?.value?.uid == null) {
    return null;
  }
  final user = auth.asData!.value!;
  final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
  return docRef;
});

/// !Get current user's RemoveAd state.
/// Value "true" means user has purchased the "RemoveAd" item.
final removeAdStateStreamProvider = StreamProvider.autoDispose<bool>(
  (ref) async* {
    final userDocRef = ref.watch(userFirestoreDocRefProvider);
    if (userDocRef == null) {
      yield false;
    } else {
      // Listen to user firestore doc's latest value.
      yield* userDocRef.snapshots().map(
        (snapshot) {
          if (!snapshot.exists || snapshot.data() == null) {
            return false;
          }
          final json = snapshot.data()!;
          final val = json[kUserAdRemovedKey] as bool?;
          return val ?? false;
        },
      );
    }
  },
);

final adIsRemovedProvider = StateProvider.autoDispose<bool>((ref) {
  return ref.watch(removeAdStateStreamProvider).maybeWhen(
        data: (val) => val,
        orElse: () => false,
      );
});

/// !Get current user's coins.
final userCoinsStreamProvider = StreamProvider.autoDispose<int>((ref) async* {
  final userDocRef = ref.watch(userFirestoreDocRefProvider);
  final localCoins = ref.watch(mySettingsProvider).rewardCoins;
  if (userDocRef == null) {
    yield localCoins;
  } else {
    yield* userDocRef.snapshots().map(
      (snapshot) {
        if (!snapshot.exists || snapshot.data() == null) {
          return localCoins;
        }
        final json = snapshot.data()!;
        final val = (json[kNumCoinsKey] as int?) ?? 0;
        if (localCoins > 0) {
          ref
              .read(userFirestoreDocRefProvider)
              ?.update({kNumCoinsKey: val + localCoins});
          ref.read(mySettingsProvider).rewardCoins -= localCoins;
        }
        return val + localCoins;
      },
    );
  }
});

/// ! Use riverpod to get/set current user's number of coins.
final userCoinsProvider = StateProvider.autoDispose<int>((ref) {
  return ref.watch(userCoinsStreamProvider).maybeWhen(
        data: (val) => val,
        orElse: () => ref.watch(mySettingsProvider).rewardCoins,
      );
});
