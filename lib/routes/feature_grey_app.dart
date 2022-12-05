import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// Dedicated to Mr. Elder, R.I.P.
class GreyAppExample extends StatefulWidget {
  const GreyAppExample({super.key});

  @override
  State<GreyAppExample> createState() => _GreyAppExampleState();
}

class _GreyAppExampleState extends State<GreyAppExample> {
  bool _greyOn = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: _greyOn
          ? ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.color),
              child: _appUI(),
            )
          : _appUI(),
    );
  }

  Widget _appUI() {
    return MaterialApp(
      home: ListView(
        children: [
          Image.asset('res/images/elder.jpeg', width: 200),
          Center(
            child: Text(
              '1926.08.17 - 2022.11.30',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Divider(),
          SwitchListTile.adaptive(
            secondary: Icon(CommunityMaterialIcons.candle),
            title: Text('R.I.P.'),
            subtitle: Text('Turn the switch on to make app grey scale'),
            value: _greyOn,
            onChanged: (v) => setState(() => _greyOn = v),
          ),
          ButtonBar(
            children: [
              ElevatedButton.icon(
                onPressed: () => _snack('+1s'),
                icon: Icon(CommunityMaterialIcons.glasses),
                label: Text('+1s'),
              ),
              ElevatedButton.icon(
                onPressed: () => _snack('🕯🕯🕯 Thank you! Merci beaucoup!'),
                icon: Icon(Icons.waving_hand),
                label: Text('bye'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _snack(String msg) {
    kAnalytics?.logEvent(name: 'Elder_RIP', parameters: {'msg': msg});
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }
}
