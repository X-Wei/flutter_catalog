import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'feature_store_secrets.dart';

class InterstitialAdExample extends StatefulWidget {
  const InterstitialAdExample({super.key});

  @override
  State<InterstitialAdExample> createState() => _InterstitialAdExampleState();
}

class _InterstitialAdExampleState extends State<InterstitialAdExample> {
  InterstitialAd? _interstitialAd;
  static const _kMaxLoadAdRetries = 3;
  int _loadAdAttempts = 0;
  bool _personalizeAds = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: MySecretsHelper.interstitialAdUnitId,
      request: AdRequest(nonPersonalizedAds: !_personalizeAds),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          setState(() {});
          _loadAdAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _loadAdAttempts += 1;
          _interstitialAd = null;
          setState(() {});
          if (_loadAdAttempts <= _kMaxLoadAdRetries) {
            _loadInterstitialAd();
          }
        },
      ),
    );
  }

  Future<bool> _showInterstitialAd() async {
    if (_interstitialAd != null) {
      // Listen for lifecycle events, such as when the ad is shown or dismissed.
      // Set this before showing the ad to receive notifications for these events.
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _loadInterstitialAd();
        },
      );
      await _interstitialAd!.show();
      return true;
    } else {
      debugPrint('ad is null, do nothing!');
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Text(
          '''
          Interstitial ad.\n
          Interstitial ads are full-screen ads that cover the interface of their host app. They're typically displayed at natural transition points in the flow of an app, such as between activities or during the pause between levels in a game. When an app shows an interstitial ad, the user has the choice to either tap on the ad and continue to its destination or close it and return to the app.

          (Click below button to show the interstitial ad before showing the second page.)
          ''',
        ),
        SizedBox(height: 32),
        SwitchListTile.adaptive(
          title: Text('Personalized Ads'),
          value: _personalizeAds,
          onChanged: (p) => setState(() {
            _personalizeAds = p;
            _loadAdAttempts = 0;
            _interstitialAd = null;
            _loadInterstitialAd();
          }),
        ),
        ElevatedButton.icon(
          onPressed: _interstitialAd == null
              ? null
              : () async {
                  final adShown = await _showInterstitialAd();
                  if (!mounted) return;
                  if (adShown) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => _buildSecondPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Ad not displayed, please retry!')),
                    );
                  }
                },
          icon: _interstitialAd == null
              ? CircularProgressIndicator()
              : Icon(Icons.category),
          label: Text('Click to show ad'),
        ),
      ],
    );
  }

  Scaffold _buildSecondPage() {
    return Scaffold(
      appBar: AppBar(title: Text('Second page')),
      body: Center(
        child: Image.asset('res/images/animated_flutter_lgtm.gif'),
      ),
    );
  }
}
