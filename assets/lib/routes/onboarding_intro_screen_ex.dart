import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../constants.dart';

class IntroductionScreenExample extends StatelessWidget {
  const IntroductionScreenExample({super.key});

  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => Scaffold(
          body: SafeArea(child: IntroductionScreenExample()),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: IntroductionScreen(
        next: const Icon(Icons.navigate_next),
        // showBackButton: true, ! showBack and showSkip can't be both be true.
        // back: const Icon(Icons.arrow_back),
        showSkipButton: true,
        skip: const Text('Skip'),
        onDone: Navigator.of(context).pop,
        done: const Text("Done"),
        dotsFlex: 3,
        pages: [
          PageViewModel(
            //! The title/body can either be strings or widgets.
            titleWidget: kAppIcon,
            body: 'Welcome to the Flutter Catalog app!',
          ),
          PageViewModel(
            title: 'Examples',
            body:
                'You can find many examples here, browse them by category, bookmark your favorite ones!',
            image: Image.asset('screenshots/Screenshot_1541613187.png'),
          ),
          PageViewModel(
            title: 'Preview tab',
            body: 'Open and interact with the preview pages.',
            image: Image.asset('screenshots/Screenshot_1541613193.png'),
          ),
          PageViewModel(
            title: 'Code tab',
            body: "Open the source code tab to see how it's implemented.",
            image: Image.asset('screenshots/Screenshot_1541613197.png'),
          ),
          PageViewModel(
            title: 'Enjoy!',
            bodyWidget: Column(
              children: [
                Text('Explore the demos and learn Flutter anywhere as you go!\n'
                    'And you are more than welcome to contribute to this open-source app :)'),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.code),
                    title: Text('Source code on GitHub'),
                    onTap: () => url_launcher.launchUrl(Uri.parse(GITHUB_URL)),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.bug_report),
                    title: const Text('Report issue on GitHub'),
                    onTap: () =>
                        url_launcher.launchUrl(Uri.parse('$GITHUB_URL/issues')),
                  ),
                ),
              ],
            ),
            image: Image.asset('res/images/dart-side.png'),
          ),
        ],
      ),
    );
  }
}
