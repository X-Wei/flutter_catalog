import 'package:flutter/material.dart';

// Adapted from Tensor Programming's multi-page app tutorial:
// https://github.com/tensor-programming/dart_flutter_multi_page_app.
class RoutesExample extends StatelessWidget {
  const RoutesExample({Key key}) : super(key: key);

  /// Route name is useful for navigating between routes.
  /// ! Note: in the Flutter Catalog each example's names are class names
  /// (cf. [routeName] in my_route.dart). That's why we know this page's route
  /// name is "/RoutesExample".
  /// But be careful not to use [--obfuscate] flag when building the apk,
  /// otherwise [runtimeType.toString()] changes
  /// (cf. https://flutter.dev/docs/deployment/obfuscate#caveat).
  static const kRouteName = '/RoutesExample';

  @override
  Widget build(BuildContext context) {
    debugPrint('RouteName=${ModalRoute.of(context).settings.name}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Page 1'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator maintains a stack-like structure of pages. Jumping
            // between routes is by push/pop of Navigator.
            Navigator.push(context, _PageTwo());
          },
          child: const Text('Go to page two'),
        ),
      ),
    );
  }
}

// <void> means this route returns nothing.
class _PageTwo extends MaterialPageRoute<void> {
  _PageTwo()
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Page 2'),
              elevation: 1.0,
            ),
            // *Note*: use a Builder instead of directly giving the body, so
            // that Scaffold.of(context) won't throw exception, c.f.
            // https://stackoverflow.com/a/51304732.
            body: Builder(
              builder: (BuildContext context) => Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push<T> returns a Future<T>, which is the
                    // return value of the pushed route when it's popped.
                    Navigator.push<String>(context, _PageThree())
                        .then((returnVal) {
                      if (returnVal != null) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You clicked: $returnVal'),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {},
                            ),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text('Go to page 3'),
                ),
              ),
            ),
          );
        });
}

// MaterialPageRoute<String> returns a Future<String>.
class _PageThree extends MaterialPageRoute<String> {
  _PageThree()
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Last page'),
              elevation: 2.0,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const CircleAvatar(child: Text('1')),
                    title: const Text('user1@example.com'),
                    onTap: () => Navigator.pop(context, 'user1@example.com'),
                  ),
                  ListTile(
                    leading: const CircleAvatar(child: Text('2')),
                    title: const Text('user2@example.com'),
                    onTap: () => Navigator.pop(context, 'user2@example.com'),
                  ),
                  ListTile(
                    leading: const CircleAvatar(child: Text('3')),
                    title: const Text('user3@example.com'),
                    onTap: () => Navigator.pop(context, 'user3@example.com'),
                  ),
                  const Divider(),
                  MaterialButton(
                    onPressed: () {
                      // Pops until reaching a route with that route name.
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName(RoutesExample.kRouteName),
                      );
                    },
                    child: const Text('Go home'),
                  ),
                ],
              ),
            ),
          );
        });
}
