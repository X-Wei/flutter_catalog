import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'changelog.dart';

class WhatsNewPage extends StatelessWidget {
  final Widget title;
  final Widget buttonText;
  final List<ListTile>? items;
  final VoidCallback? onButtonPressed;
  final bool changelog;
  final String? changes;
  final Color? backgroundColor;
  final Color? buttonColor;
  final String? path;
  final MarkdownTapLinkCallback? onTapLink;
  final bool adaptive;

  const WhatsNewPage({
    required this.items,
    required this.title,
    required this.buttonText,
    this.onButtonPressed,
    this.backgroundColor,
    this.buttonColor,
    this.onTapLink,
    this.adaptive = true,
  })  : changelog = false,
        changes = null,
        path = null;

  const WhatsNewPage.changelog({
    this.title = const Text(
      'Changelog',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    this.buttonText = const Text(
      'Continue',
      style: const TextStyle(color: Colors.white),
    ),
    this.onButtonPressed,
    this.changes,
    this.backgroundColor,
    this.buttonColor,
    this.path,
    this.onTapLink,
    this.adaptive = true,
  })  : changelog = true,
        items = null;

  static void showDetailPopUp(
    BuildContext context,
    String title,
    String detail,
  ) async {
    void showDemoDialog<T>({
      required BuildContext context,
      required Widget child,
    }) {
      showDialog<T>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => child,
      );
    }

    return showDemoDialog<Null>(
      context: context,
      child: AlertDialog(
        title: Text(title),
        content: Text(detail),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(items != null || changelog);
    if (adaptive &&
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS)) {
      return _buildIOS(context);
    }
    return _buildAndroid(context);
  }

  Widget _buildAndroid(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: buttonColor ?? Theme.of(context).colorScheme.primary,
      foregroundColor: buttonColor != null
          ? (buttonColor!.computeLuminance() > 0.5
              ? Colors.black
              : Colors.white)
          : Theme.of(context).colorScheme.onPrimary,
    );
    if (changelog) {
      return Scaffold(
        backgroundColor:
            backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 10.0,
                left: 0.0,
                right: 0.0,
                child: title,
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 50.0,
                bottom: 80.0,
                child: ChangeLogView(
                  changes: changes,
                  path: path,
                  onTapLink: onTapLink,
                  adaptive: adaptive,
                ),
              ),
              Positioned(
                bottom: 5.0,
                right: 10.0,
                left: 10.0,
                child: ListTile(
                  title: ElevatedButton(
                    child: buttonText,
                    style: buttonStyle,
                    onPressed: onButtonPressed != null
                        ? onButtonPressed
                        : () {
                            Navigator.pop(context);
                          },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (items != null) {
      return Scaffold(
        backgroundColor:
            backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 10.0,
                left: 0.0,
                right: 0.0,
                child: title,
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 50.0,
                bottom: 80.0,
                child: ListView(
                  children: items!
                      .map(
                        (ListTile item) => ListTile(
                          title: item.title,
                          subtitle: item.subtitle,
                          leading: item.leading,
                          trailing: item.trailing,
                          onTap: item.onTap,
                          onLongPress: item.onLongPress,
                        ),
                      )
                      .toList(),
                ),
              ),
              Positioned(
                bottom: 5.0,
                right: 10.0,
                left: 10.0,
                child: ListTile(
                  title: ElevatedButton(
                    child: buttonText,
                    style: buttonStyle,
                    onPressed: onButtonPressed != null
                        ? onButtonPressed
                        : () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildIOS(BuildContext context) {
    Widget? child;
    if (changelog) {
      child = ChangeLogView(
        changes: changes,
        path: path,
        onTapLink: onTapLink,
        adaptive: adaptive,
      );
    } else if (items != null) {
      child = Material(
        child: ListView(
          children: items!,
        ),
      );
    }
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: title,
      ),
      child: SafeArea(
        child: child ?? Container(),
      ),
    );
  }
}
