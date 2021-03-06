import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as english_words;
import 'package:flutter/scheduler.dart';

class FeatureDiscoveryExample extends StatelessWidget {
  const FeatureDiscoveryExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FeatureDiscovery(
      child: const _DemoPage(),
    );
  }
}

class _DemoPage extends StatefulWidget {
  const _DemoPage({Key key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<_DemoPage> {
  static const _kFeatureId1Add = 'feature1_add';
  static const _kFeatureId2Sub = 'feature2_substract';
  static const _kFeatureId3Refresh = 'feature3_refresh';

  List<String> _strsToShow;
  GlobalKey<EnsureVisibleState> _ensureVisibleGlobalKey;

  List<String> _getRandomStrings() {
    return <String>[
      for (final wordPair in english_words.generateWordPairs().take(20))
        wordPair.asPascalCase
    ];
  }

  @override
  void initState() {
    super.initState();
    this._ensureVisibleGlobalKey = GlobalKey<EnsureVisibleState>();
    this._strsToShow = _getRandomStrings();
    // !Show feature discovery right after the page is ready.
    SchedulerBinding.instance
        .addPostFrameCallback((Duration duration) => _showDiscovery());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFabColumn(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            const Text(
                'This is a simple page showing a list of random words, and has 3 '
                'buttons: add one / remove one / refresh. \n\n'
                'Feature discovery will go through and introduce them.'),
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              onPressed: _showDiscovery,
              label: const Text('Start feature discovery'),
            ),
            const Divider(),
            for (final str in _strsToShow)
              Card(child: ListTile(title: Text(str))),
            _buildRefreshBtn(context),
          ],
        ),
      ),
    );
  }

  DescribedFeatureOverlay _buildRefreshBtn(BuildContext context) {
    return DescribedFeatureOverlay(
      featureId: _kFeatureId3Refresh,
      tapTarget: const Icon(Icons.refresh),
      title: const Text('Refresh'),
      description: const Text(
          'Tap the refresh button to re-generate the random text list.'),
      backgroundColor: Theme.of(context).primaryColor,
      onOpen: () async {
        WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
          _ensureVisibleGlobalKey.currentState.ensureVisible(
            preciseAlignment: 0.5,
            duration: const Duration(milliseconds: 400),
          );
        });
        return true;
      },
      // !Use EnsureVisible to scroll to the button during Feature Discovery.
      // !! **Note**: to make this work, the scrollable widget must be a
      // !! SingleChildScrollView, ListView will NOT work!
      child: EnsureVisible(
        key: _ensureVisibleGlobalKey,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            setState(() => this._strsToShow = _getRandomStrings());
          },
          label: const Text('Refresh words'),
        ),
      ),
    );
  }

  Column _buildFabColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // !For every widget that you want to describe using Feature Discovery,
        // ! you will need to add a DescribedFeatureOverlay.
        DescribedFeatureOverlay(
          // !Unique id that identifies this overlay.
          featureId: _kFeatureId1Add,
          // !The widget that will be displayed as the tap target.
          tapTarget: const Icon(Icons.plus_one),
          contentLocation: ContentLocation.above,
          title: const Text('Plus one'),
          description:
              const Text('Tap the plus icon to add an item to your list.'),
          backgroundColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            onPressed: () {
              setState(() => this._strsToShow.insert(
                  0, english_words.generateWordPairs().first.asCamelCase));
            },
            heroTag: 'plus_one',
            child: const Icon(Icons.plus_one),
          ),
        ),
        const SizedBox(height: 4),
        DescribedFeatureOverlay(
          featureId: _kFeatureId2Sub,
          tapTarget: const Icon(Icons.exposure_minus_1),
          title: const Text('Minus one'),
          description:
              const Text('Tap the minus icon to remove an item to your list.'),
          backgroundColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            onPressed: () {
              setState(() => this._strsToShow.removeAt(0));
            },
            heroTag: 'minus_one',
            child: const Icon(Icons.exposure_minus_1),
          ),
        ),
      ],
    );
  }

  Future<void> _showDiscovery() async {
    // !Clear the "feature discovered" data, otherwise it'll show up only for
    // !the first time.
    await FeatureDiscovery.clearPreferences(context,
        <String>{_kFeatureId1Add, _kFeatureId2Sub, _kFeatureId3Refresh});
    // ! Start feature discovery
    FeatureDiscovery.discoverFeatures(
      context,
      // Feature ids for every feature that you want to showcase in order.
      const <String>{_kFeatureId1Add, _kFeatureId2Sub, _kFeatureId3Refresh},
    );
    // final isShown = await FeatureDiscovery.hasPreviouslyCompleted(
    //     context, _kFeatureId1);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('FeatureDiscovery shown=$isShown'),
    // ));
  }
}
