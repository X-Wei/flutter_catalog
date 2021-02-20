import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimationsPackageExample extends StatelessWidget {
  const AnimationsPackageExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Divider(thickness: 2, color: Colors.black),
        ListTile(
          title: const Text('1. OpenContainer'),
          subtitle: const Text(
              'A container that grows to fill the screen to reveal new content when tapped.'),
          trailing: IconButton(
            tooltip: 'Documentation',
            icon: const Icon(Icons.open_in_new),
            onPressed: () => launch(
                'https://pub.dev/documentation/animations/latest/animations/OpenContainer-class.html'),
          ),
        ),
        OpenContainer(
          transitionDuration: const Duration(milliseconds: 500),
          closedBuilder: (ctx, action) => const ListTile(
            title: Text('click me'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          openBuilder: (ctx, action) => const Scaffold(
            body: Center(
              child: Text('new page'),
            ),
          ),
        ),
        const Divider(thickness: 2, color: Colors.black),
        ListTile(
          title: const Text('2. PageTransitionSwitcher'),
          subtitle: const Text(
              'Transition from an old child to a new child, similar to AnimationSwitcher'),
          trailing: IconButton(
            tooltip: 'Documentation',
            icon: const Icon(Icons.open_in_new),
            onPressed: () => launch(
                'https://pub.dev/documentation/animations/latest/animations/PageTransitionSwitcher-class.html'),
          ),
        ),
        const SizedBox(
          height: 200,
          child: _PageTransitionSwitcherEx(),
        ),
        const Divider(thickness: 2, color: Colors.black),
        ListTile(
          title: const Text('3. SharedAxisTransition'),
          subtitle: const Text(
              'Transition animation between UI elements that have a spatial or navigational relationship.'),
          trailing: IconButton(
            tooltip: 'Documentation',
            icon: const Icon(Icons.open_in_new),
            onPressed: () => launch(
                'https://pub.dev/documentation/animations/latest/animations/SharedAxisTransition-class.html'),
          ),
        ),
        const SizedBox(
          height: 300,
          child: _SharedAxisEx(),
        ),
        const Divider(thickness: 2, color: Colors.black),
        ListTile(
          title: const Text('4. showModal()'),
          subtitle: const Text('Displays a dialog with animation.'),
          trailing: IconButton(
            tooltip: 'Documentation',
            icon: const Icon(Icons.open_in_new),
            onPressed: () => launch(
                'https://pub.dev/documentation/animations/latest/animations/showModal.html'),
          ),
        ),
        ElevatedButton(
          onPressed: () => showModal(
            configuration: const FadeScaleTransitionConfiguration(
              transitionDuration: Duration(milliseconds: 500),
            ),
            context: context,
            builder: (ctx) => const AlertDialog(
              title: Text('New dialog'),
              content: Text('blahblahblah'),
            ),
          ),
          child: const Text('Show dialog'),
        ),
      ],
    );
  }
}

class _PageTransitionSwitcherEx extends StatefulWidget {
  const _PageTransitionSwitcherEx({Key key}) : super(key: key);

  @override
  __PageTransitionSwitcherExState createState() =>
      __PageTransitionSwitcherExState();
}

class __PageTransitionSwitcherExState extends State<_PageTransitionSwitcherEx> {
  static const _tabs = <Widget>[
    // *Note*: when changed child is of the same type as previous one, set the
    // key property explicitly.
    Icon(Icons.looks_one, size: 48, key: ValueKey(1)),
    Icon(Icons.looks_two, size: 48, key: ValueKey(2)),
  ];
  static const _btmNavbarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Tab1',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Tab2',
    ),
  ];

  int _currentTabIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
          child: _tabs[_currentTabIdx],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _btmNavbarItems,
        currentIndex: _currentTabIdx,
        onTap: (idx) => setState(() => this._currentTabIdx = idx),
      ),
    );
  }
}

class _SharedAxisEx extends StatefulWidget {
  const _SharedAxisEx({Key key}) : super(key: key);

  @override
  __SharedAxisExState createState() => __SharedAxisExState();
}

class __SharedAxisExState extends State<_SharedAxisEx> {
  final _pages = <Widget>[
    // *Note*: when changed child is of the same type as previous one, set the
    // key property explicitly.
    const Icon(Icons.looks_one, size: 64, key: ValueKey(1)),
    const Icon(Icons.looks_two, size: 64, key: ValueKey(2)),
    const Icon(Icons.looks_3, size: 64, key: ValueKey(3)),
  ];

  int _currentPageIdx = 0;
  SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageTransitionSwitcher(
                duration: const Duration(seconds: 1),
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) =>
                        SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: this._transitionType,
                  child: child,
                ),
                child: _pages[_currentPageIdx],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: this._currentPageIdx == 0
                        ? null
                        : () => setState(() => this._currentPageIdx--),
                    child: const Text('BACK'),
                  ),
                  ElevatedButton(
                    onPressed: this._currentPageIdx == 2
                        ? null
                        : () => setState(() => this._currentPageIdx++),
                    child: const Text('NEXT'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildControlBar(),
    );
  }

  Widget _buildControlBar() {
    return Container(
      color: Theme.of(context).primaryColorLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('SharedAxisTransitionType'),
            trailing: DropdownButton<SharedAxisTransitionType>(
              value: _transitionType,
              items: [
                for (final val in SharedAxisTransitionType.values)
                  DropdownMenuItem(
                    value: val,
                    child: Text(val
                        .toString()
                        .substring('SharedAxisTransitionType.'.length)),
                  )
              ],
              onChanged: (SharedAxisTransitionType val) =>
                  setState(() => this._transitionType = val),
            ),
          ),
        ],
      ),
    );
  }
}
