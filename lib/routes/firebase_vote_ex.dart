import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../my_route.dart';

// NOTE: to add firebase support, first go to firebase console, generate the
// firebase json file, and add configuration lines in the gradle files.
// C.f. this commit: https://github.com/X-Wei/flutter_catalog/commit/48792cbc0de62fc47e0e9ba2cd3718117f4d73d1.
class FirebaseVoteExample extends MyRoute {
  const FirebaseVoteExample(
      [String sourceFile = 'lib/routes/firebase_vote_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Firestore voting app';

  @override
  get description => 'Vote for your favorite programming language';

  @override
  get links => {
        'Youtube video': 'https://www.youtube.com/watch?v=DqJ_KjFzL9I',
        'Codelab':
            'https://codelabs.developers.google.com/codelabs/flutter-firebase/#0',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return VotePage();
  }
}

// Adapted from the flutter firestore "babyname voter" codelab:
// https://codelabs.developers.google.com/codelabs/flutter-firebase/#0
class VotePage extends StatefulWidget {
  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        // In firestore console I added a "language_voting" collection.
        stream: Firestore.instance.collection('language_voting').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          } else {
            return ListView(
              children: snapshot.data.documents
                  .map((data) => _buildListItem(context, data))
                  .toList(),
            );
          }
        },
      ),
    );
  }

  // Build one list item given a data snapshot.
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () => this._upvote(record),
              ),
              Text(record.votes.toString()),
            ],
          ),
        ),
      ),
    );
  }

  // Upvote one record.
  void _upvote(Record record) {
    // Doing upvotes via transaction makes each update atomic, there'll be no
    // race conditions.
    Firestore.instance.runTransaction((transaction) async {
      final freshSnapshot = await transaction.get(record.firestoreDocReference);
      // Get the most fresh record.
      final freshRecord = Record.fromSnapshot(freshSnapshot);
      await transaction.update(
          record.firestoreDocReference, {'votes': freshRecord.votes + 1});
    });
  }
}

// Custom data class for holding "{name,vote}" records.
class Record {
  final String name;
  final int votes;
  // Reference to this record as a firestore document.
  final DocumentReference firestoreDocReference;

  Record.fromMap(Map<String, dynamic> map,
      {@required this.firestoreDocReference})
      : assert(map['language'] != null),
        assert(map['votes'] != null),
        name = map['language'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, firestoreDocReference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
