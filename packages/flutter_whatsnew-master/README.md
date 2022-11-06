[![Flutter Community: flutter_whatsnew](https://fluttercommunity.dev/_github/header/flutter_whatsnew)](https://github.com/fluttercommunity/community)

[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)
![github pages](https://github.com/fluttercommunity/flutter_whatsnew/workflows/github%20pages/badge.svg)

# flutter_whatsnew

[![pub package](https://img.shields.io/pub/v/flutter_whatsnew.svg)](https://pub.dartlang.org/packages/flutter_whatsnew)

A Flutter Plugin to Show a Whats New page. 

Online Demo: https://fluttercommunity.github.io/flutter_whatsnew/

## Usage

To use this plugin, add `flutter_whatsnew` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

``` dart
// Import package
import 'package:flutter_whatsnew/flutter_whatsnew.dart';
```

![changelog](https://github.com/fluttercommunity/flutter_whatsnew/blob/master/doc/screenshots/changes.png)

If using `WhatsNewPage.changelog` and you want it to pickup the `CHANGELOG.md' add it to the Flutter asset directory, otherwise manually pass in the .md file with the changes. This uses the full markdown previewer.

``` yaml
  assets:
    - CHANGELOG.md
```

![changelog](https://github.com/fluttercommunity/flutter_whatsnew/blob/master/doc/screenshots/changelog.png)

## Example

``` dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';

void main() {
  runApp(MaterialApp(home: ShowWhatsNew()));
}

class ShowWhatsNew extends StatelessWidget {
  final double textScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Show Changelog"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WhatsNewPage.changelog(
                          title: Text(
                            "What's New",
                            textScaleFactor: textScaleFactor,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              // Text Style Needed to Look like iOS 11
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          buttonText: Text(
                            'Continue',
                            textScaleFactor: textScaleFactor,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            Container(height: 50.0),
            RaisedButton(
              child: Text("Show Changes"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WhatsNewPage(
                          title: Text(
                            "What's New",
                            textScaleFactor: textScaleFactor,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              // Text Style Needed to Look like iOS 11
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          buttonText: Text(
                            'Continue',
                            textScaleFactor: textScaleFactor,
                            style: const TextStyle(color: Colors.white),
                          ),
                          // Create a List of WhatsNewItem for use in the Whats New Page
                          // Create as many as you need, it will be scrollable
                          items: <ListTile>[
                            ListTile(
                              leading: const Icon(Icons.color_lens),
                              title: Text(
                                'Dark Theme',
                                textScaleFactor: textScaleFactor,
                              ), //Title is the only Required Item
                              subtitle: Text(
                                'Black and grey theme (Tap to Change)',
                                textScaleFactor: textScaleFactor,
                              ),
                              onTap: () {
                                // You Can Navigate to Locations in the App
                                Navigator.of(context).pushNamed("/settings");
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.map),
                              title: Text(
                                'Google Maps',
                                textScaleFactor: textScaleFactor,
                              ),
                              subtitle: Text(
                                'Open Address Links in Google Maps instead of Apple Maps (Tap to Change)',
                                textScaleFactor: textScaleFactor,
                              ),
                              onTap: () {
                                // You Can Navigate to Locations in the App
                                Navigator.of(context).pushNamed("/settings");
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.notifications_active),
                              title: Text(
                                'Push Notifications',
                                textScaleFactor: textScaleFactor,
                              ),
                              subtitle: Text(
                                'Stay tuned for important information that can be pushed to you',
                                textScaleFactor: textScaleFactor,
                              ),
                              onTap: () {
                                WhatsNewPage.showDetailPopUp(
                                  context,
                                  'Info',
                                  "You can turn off push notifications any time in your application settings.",
                                );
                              },
                            ),
                          ], //Required
                        ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}

```
