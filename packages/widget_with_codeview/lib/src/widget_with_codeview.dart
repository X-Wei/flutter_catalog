library widget_with_codeview;

import 'package:flutter/material.dart';

import 'source_code_view.dart';

class WidgetWithCodeView extends SourceCodeView {
  // If not given, will just show the SourceCodeView (see https://github.com/X-Wei/widget_with_codeview/issues/10).
  final Widget? child;
  // Can be used to add a hook when switching tabs.
  final void Function(TabController)? tabChangeListener;

  const WidgetWithCodeView({
    super.key,
    required super.filePath,
    super.codeContent,
    this.child,
    this.tabChangeListener,
    super.codeLinkPrefix,
    super.showLabelText,
    super.iconBackgroundColor,
    super.iconForegroundColor,
    super.labelBackgroundColor,
    super.labelTextStyle,
    super.headerWidget,
    super.footerWidget,
    super.lightTheme,
    super.darkTheme,
  });

  static const _TABS = <Widget>[
    Tab(
      child: ListTile(
        leading: Icon(Icons.phone_android, color: Colors.white),
        title: Text('Preview', style: TextStyle(color: Colors.white)),
      ),
    ),
    Tab(
      child: ListTile(
        leading: Icon(Icons.code, color: Colors.white),
        title: Text('Code', style: TextStyle(color: Colors.white)),
      ),
    ),
  ];

  @override
  _WidgetWithCodeViewState createState() => _WidgetWithCodeViewState(
      tabChangeListener: tabChangeListener, child: child);
}

//? Need to override SourceCodeViewState rather than State<WidgetWithCodeView>.
//! otherwise won't compile, because WidgetWithCodeView extends SourceCodeView.
//! I use this inheritance to use "parameter forwarding" feature in dart 2.17.
class _WidgetWithCodeViewState extends SourceCodeViewState
    with SingleTickerProviderStateMixin {
  Widget? child;
  late TabController _tabController;
  void Function(TabController)? tabChangeListener;

  _WidgetWithCodeViewState({this.child, this.tabChangeListener});

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (tabChangeListener != null) {
      _tabController.addListener(
        () => tabChangeListener!(_tabController),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String get routeName => '/${this.runtimeType.toString()}';

  @override
  Widget build(BuildContext context) {
    final sourceCodeView = super.build(context);
    return Scaffold(
      appBar: (child == null)
          ? null
          : _ColoredTabBar(
              color: Theme.of(context).primaryColor,
              tabBar: TabBar(
                controller: _tabController,
                tabs: WidgetWithCodeView._TABS,
              ),
            ),
      body: (child == null)
          ? sourceCodeView
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                _AlwaysAliveWidget(child: this.child!),
                _AlwaysAliveWidget(child: sourceCodeView),
              ],
            ),
    );
  }
}

// This widget is always kept alive, so that when tab is switched back, its
// child's state is still preserved.
class _AlwaysAliveWidget extends StatefulWidget {
  final Widget child;

  const _AlwaysAliveWidget({Key? key, required this.child}) : super(key: key);

  @override
  _AlwaysAliveWidgetState createState() => _AlwaysAliveWidgetState();
}

class _AlwaysAliveWidgetState extends State<_AlwaysAliveWidget>
    with AutomaticKeepAliveClientMixin<_AlwaysAliveWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context); // This build method is annotated "@mustCallSuper".
    return this.widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

class _ColoredTabBar extends Container implements PreferredSizeWidget {
  final Color color;
  final TabBar tabBar;

  _ColoredTabBar({Key? key, required this.color, required this.tabBar})
      : super(key: key);

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Material(
        elevation: 4.0,
        color: color,
        child: tabBar,
      );
}
