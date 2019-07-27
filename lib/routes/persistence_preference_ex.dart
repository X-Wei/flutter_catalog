import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceExample extends StatefulWidget {
  const SharedPreferenceExample({Key key}) : super(key: key);

  @override
  _SharedPreferenceExampleState createState() =>
      _SharedPreferenceExampleState();
}

class _SharedPreferenceExampleState extends State<SharedPreferenceExample> {
  SharedPreferences _prefs;
  static const String kDemoNumberPrefKey = 'demo_number_pref';
  static const String kDemoBooleanPrefKey = 'demo_boolean_pref';
  int _numberPref = 0;
  bool _boolPref = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._prefs = prefs);
        _loadNumberPref();
        _loadBooleanPref();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Text('Number preference:'),
            Text('${this._numberPref}'),
            RaisedButton(
              child: Text('Increment'),
              onPressed: () => this._setNumberPref(this._numberPref + 1),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Text('Boolean preference:'),
            Text('${this._boolPref}'),
            RaisedButton(
              child: Text('Toggle'),
              onPressed: () => this._setBooleanPref(!this._boolPref),
            ),
          ],
        ),
      ],
    );
  }

  // Loads number preference into this._numberPref.
  void _loadNumberPref() {
    setState(() {
      this._numberPref = this._prefs.getInt(kDemoNumberPrefKey) ?? 0;
    });
  }

  // Loads boolean preference into this._numberPref.
  void _loadBooleanPref() {
    setState(() {
      this._boolPref = this._prefs.getBool(kDemoBooleanPrefKey) ?? false;
    });
  }

  Future<Null> _setNumberPref(int val) async {
    await this._prefs.setInt(kDemoNumberPrefKey, val);
    _loadNumberPref();
  }

  Future<Null> _setBooleanPref(bool val) async {
    await this._prefs.setBool(kDemoBooleanPrefKey, val);
    _loadBooleanPref();
  }
}
