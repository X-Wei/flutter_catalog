import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// NOTE: to add firebase support, first go to firebase console, generate the
// firebase json file, and add configuration lines in the gradle files.
// C.f. this commit: https://github.com/X-Wei/flutter_catalog/commit/48792cbc0de62fc47e0e9ba2cd3718117f4d73d1.

// Adapted from the flutter firestore "babyname voter" codelab:
// https://codelabs.developers.google.com/codelabs/flutter-firebase/#0
class FirebaseVoteExample extends StatefulWidget {
  const FirebaseVoteExample({Key key}) : super(key: key);
  @override
  _FirebaseVoteExampleState createState() => _FirebaseVoteExampleState();
}

class _FirebaseVoteExampleState extends State<FirebaseVoteExample> {
  // We use SharedPreferences to keep track of which languages are voted.
  SharedPreferences _preferences;
  static const kVotedPreferenceKeyPrefx = 'AlreadyVotedFor_';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => this._preferences = prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        // In firestore console I added a "language_voting" collection.
        stream: FirebaseFirestore.instance
            .collection('language_voting')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          } else {
            final List<_LangaugeVotingRecord> records = snapshot.data.docs
                .map((snapshot) => _LangaugeVotingRecord.fromSnapshot(snapshot))
                .toList()
                  ..sort((record1, record2) => record2.votes - record1.votes);
            return ListView(
              children: records
                  .map((record) => _buildListItem(context, record))
                  .toList(),
            );
          }
        },
      ),
    );
  }

  // Returns whether you already voted for lang.
  bool _isVoted(String lang) {
    return this._preferences.getBool('$kVotedPreferenceKeyPrefx$lang') ?? false;
  }

  // Mark a language as voted or not-voted.
  Future<void> _markVotedStatus(String lang, bool voted) async {
    this._preferences.setBool('$kVotedPreferenceKeyPrefx$lang', voted);
  }

  // Build a list item corresponding to a _LanguageVotingRecord.
  Widget _buildListItem(BuildContext context, _LangaugeVotingRecord record) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.language),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: this._isVoted(record.language)
                      ? Colors.blue
                      : Colors.grey,
                ),
                onPressed: () => this._toggleVoted(record),
              ),
              Text(record.votes.toString()),
            ],
          ),
        ),
      ),
    );
  }

  // Toggle the voted status of one record.
  Future<void> _toggleVoted(_LangaugeVotingRecord record) async {
    try {
      // Check internet connection before doing firebase transactions.
      final result = await InternetAddress.lookup('firestore.googleapis.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        throw 'Cannot access "firestore.googleapis.com"!';
      }
      final lang = record.language;
      final int deltaVotes = this._isVoted(lang) ? -1 : 1;
      // Update votes via transactions are atomic: no race condition.
      await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          try {
            final freshSnapshot =
                await transaction.get(record.firestoreDocReference);
            // Get the most fresh record.
            final freshRecord =
                _LangaugeVotingRecord.fromSnapshot(freshSnapshot);
            transaction.update(record.firestoreDocReference,
                {'votes': freshRecord.votes + deltaVotes});
          } catch (e) {
            print(e);
            rethrow;
          }
        },
        timeout: const Duration(seconds: 3),
      );
      // Update local voted status only after transaction is successful.
      this._markVotedStatus(lang, !this._isVoted(lang));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error doing firebase transaction: $e'),
        ),
      );
    }
  }
}

// Custom data class for holding "{language,vote}" records.
class _LangaugeVotingRecord {
  final String language;
  final int votes;
  // Reference to this record as a firestore document.
  final DocumentReference firestoreDocReference;

  _LangaugeVotingRecord.fromMap(Map<String, dynamic> map,
      {@required this.firestoreDocReference})
      : assert(map['language'] != null && map['language'] is String),
        assert(map['votes'] != null && map['votes'] is int),
        language = map['language'] as String,
        votes = map['votes'] as int;

  _LangaugeVotingRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(),
            firestoreDocReference: snapshot.reference);

  @override
  String toString() => "Record<$language:$votes>";
}
