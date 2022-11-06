import 'package:flutter/material.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';

import '../constants.dart';

class WhatsNewExample extends StatelessWidget {
  const WhatsNewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return WhatsNewPage(
      title: Center(
        child: Text(
          '${kPackageInfo.appName} - v${kPackageInfo.version}',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      items: <ListTile>[
        ListTile(
          title: Text('Add "In-Action" tab'),
          leading: Icon(Icons.rocket),
          isThreeLine: true,
          subtitle: Text(
              'Add practical examples useful for building real-world applications, '
              'like user onboarding, monetization, etc.\n'
              'Will add more examples in future version.'),
        ),
        ListTile(
          title: Text('Update RewordedAdExample and InterstitialAdExample'),
          subtitle: Text('Add option to turn on/off ad personalization'),
          leading: Icon(Icons.face),
        ),
        ListTile(
          title: Text('Bug fixes & improvements'),
          leading: Icon(Icons.bug_report),
        ),
        ListTile(
          title: Text('View changelog'),
          leading: Icon(Icons.history),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _buildChangeLogPage(),
              fullscreenDialog: true,
            ),
          ),
        ),
      ],
      buttonText: const Text('OK'),
    );
  }

  Widget _buildChangeLogPage() {
    return WhatsNewPage.changelog(
      title: Text(
        "What's New",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      ),
      buttonText: Text('Continue'),
    );
  }
}
