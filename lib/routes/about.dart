import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import '../my_route.dart';
import '../my_app_meta.dart';

// Inspired by the about page in Eajy's flutter demo:
// https://github.com/Eajy/flutter_demo/blob/master/lib/route/about.dart
class MyAboutRoute extends MyRoute {
  const MyAboutRoute([String sourceFile = 'lib/routes/about.dart'])
      : super(sourceFile);

  @override
  get title => 'About';

  @override
  get links =>
      {'Doc': 'https://docs.flutter.io/flutter/material/showAboutDialog.html'};

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: APP_LOGO,
          title: Text(APP_NAME),
          subtitle: Text(APP_VERSION),
          trailing: IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showAboutDialog(
                  context: context,
                  applicationName: APP_NAME,
                  applicationVersion: APP_VERSION,
                  applicationIcon: APP_LOGO,
                  children: <Widget>[Text(APP_DESCRIPTION)]);
            },
          ),
        ),
        ListTile(
          title: Text(APP_DESCRIPTION),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('View on Google Play'),
          onTap: () => url_launcher.launch(GOOGLEPLAY_URL),
        ),
        ListTile(
          leading: Icon(Icons.code),
          title: Text('View source code on GitHub'),
          // TODO: publish code on GitHub.
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.open_in_new),
          title: Text('Visit my website'),
          onTap: () => url_launcher.launch(AUTHOR_SITE),
        ),
      ],
    );
  }
}
