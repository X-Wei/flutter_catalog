import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChangeLogView extends StatefulWidget {
  const ChangeLogView({
    this.onTapLink,
    this.path,
    this.changes,
    required this.adaptive,
  });
  final String? changes;
  final String? path;
  final bool adaptive;
  final MarkdownTapLinkCallback? onTapLink;
  @override
  _ChangeLogViewState createState() => _ChangeLogViewState();
}

class _ChangeLogViewState extends State<ChangeLogView> {
  String? _changelog;

  @override
  void initState() {
    if (widget.changes == null) {
      rootBundle.loadString(widget.path ?? "CHANGELOG.md").then((data) {
        setState(() {
          _changelog = data;
        });
      });
    } else {
      setState(() {
        _changelog = widget.changes;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_changelog == null) {
      if (widget.adaptive &&
          (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS)) {
        return Center(child: CupertinoActivityIndicator());
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
    return Markdown(
      data: _changelog!,
      onTapLink: widget.onTapLink,
    );
  }
}
