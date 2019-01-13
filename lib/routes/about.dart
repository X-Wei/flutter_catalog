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

  // These tiles are also used as drawer nav items in home route.
  List<Widget> aboutListTiles(BuildContext context) {
    return <Widget>[
      ListTile(
        title: Text(APP_DESCRIPTION),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.shop),
        title: Text('Rate on Google Play'),
        onTap: () => url_launcher.launch(GOOGLEPLAY_URL),
      ),
      ListTile(
        leading: Icon(Icons.code),
        title: Text('Source code on GitHub'),
        onTap: () => url_launcher.launch(GITHUB_URL),
      ),
      ListTile(
        leading: Icon(Icons.open_in_new),
        title: Text('Visit my website'),
        onTap: () => url_launcher.launch(AUTHOR_SITE),
      ),
    ];
  }

  @override
  Widget buildMyRouteContent(BuildContext context) {
    final header = ListTile(
      leading: kAppIcon,
      title: Text(APP_NAME),
      subtitle: Text(APP_VERSION),
      trailing: IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showAboutDialog(
              context: context,
              applicationName: APP_NAME,
              applicationVersion: APP_VERSION,
              applicationIcon: kAppIcon,
              children: <Widget>[Text(APP_DESCRIPTION)]);
        },
      ),
    );
    return ListView(
      children: <Widget>[header]..addAll(aboutListTiles(context)),
    );
  }
}
