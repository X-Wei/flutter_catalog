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
    SharedPreferences.getInstance().then((prefs) {
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
            const Text('Number preference:'),
            Text('${this._numberPref}'),
            ElevatedButton(
              onPressed: () => this._setNumberPref(this._numberPref + 1),
              child: const Text('Increment'),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Text('Boolean preference:'),
            Text('${this._boolPref}'),
            ElevatedButton(
              onPressed: () => this._setBooleanPref(!this._boolPref),
              child: const Text('Toggle'),
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

  Future<void> _setNumberPref(int val) async {
    await this._prefs.setInt(kDemoNumberPrefKey, val);
    _loadNumberPref();
  }

  Future<void> _setBooleanPref(bool val) async {
    await this._prefs.setBool(kDemoBooleanPrefKey, val);
    _loadBooleanPref();
  }
}
