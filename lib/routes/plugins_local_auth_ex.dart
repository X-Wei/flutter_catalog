import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:transparent_image/transparent_image.dart'
    show kTransparentImage;
import '../my_route.dart';

class LocalAuthExample extends MyRoute {
  const LocalAuthExample(
      [String sourceFile = 'lib/routes/plugins_local_auth_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Local auth';

  @override
  get description => 'Authenticate with biometrics(fingerprint)';

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _LocalAuthDemo(),
    );
  }
}

class _LocalAuthDemo extends StatefulWidget {
  @override
  _LocalAuthDemoState createState() => _LocalAuthDemoState();
}

class _LocalAuthDemoState extends State<_LocalAuthDemo> {
  bool _authSuccess = false;
  LocalAuthentication _localAuth;

  @override
  void initState() {
    super.initState();
    this._localAuth = LocalAuthentication();
  }

  Future<bool> _auth() async {
    setState(() => this._authSuccess = false);
    if (await this._localAuth.canCheckBiometrics == false) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Your device is NOT capable of checking biometrics.\n'
              'This demo will not work on your device!\n'
              'You must have android 6.0+ and have fingerprint sensor.'),
        ),
      );
      return false;
    }
    final authSuccess = await this._localAuth.authenticateWithBiometrics(
        localizedReason: 'Auth in to see hidden image');
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('authSuccess=$authSuccess')),
    );
    return authSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.fingerprint),
          label: Text('Auth in to view hidden image'),
          onPressed: () async {
            final authSuccess = await this._auth();
            setState(() => this._authSuccess = authSuccess);
          },
        ),
        this._authSuccess
            ? FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('res/images/animated_flutter_lgtm.gif'),
              )
            : Placeholder(),
      ],
    );
  }
}
