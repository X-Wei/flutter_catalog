import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base.dart';

class ScheduledWhatsNewPage extends StatefulWidget {
  const ScheduledWhatsNewPage({
    Key? key,
    required this.details,
    this.delay,
    this.appVersion,
    required this.child,
  }) : super(key: key);

  final WhatsNewPage details;
  final Widget child;

  /// Wait a set duration and show the dialog
  final Duration? delay;

  /// Check the last saved version and show the dialog if different (or fresh)
  final String? appVersion;

  @override
  State<ScheduledWhatsNewPage> createState() => _ScheduledWhatsNewPageState();
}

class _ScheduledWhatsNewPageState extends State<ScheduledWhatsNewPage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      check();
    });
    super.initState();
  }

  void check() async {
    if (widget.appVersion != null) {
      final settingsKey = 'last-app-version';
      final lastVersion = prefs.getString(settingsKey);
      if (lastVersion == widget.appVersion) {
        return;
      }
      await prefs.setString(settingsKey, widget.appVersion!);
    }
    if (widget.delay != null) {
      await Future<void>.delayed(widget.delay!);
    }
    show(context);
  }

  void show(BuildContext context) {
    if (!mounted) return;
    final nav = Navigator.of(context, rootNavigator: true);
    nav.push(MaterialPageRoute(
      builder: (context) => widget.details,
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
