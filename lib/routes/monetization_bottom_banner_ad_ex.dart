import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'feature_store_secrets.dart';

class BottomBannerAdExample extends StatefulWidget {
  const BottomBannerAdExample({super.key});

  @override
  State<BottomBannerAdExample> createState() => _BottomBannerAdExampleState();
}

class _BottomBannerAdExampleState extends State<BottomBannerAdExample> {
  bool _adLoaded = false;
  late BannerAd _bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    _bannerAd = BannerAd(
      adUnitId: MySecretsHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => setState(() {
          _bannerAd = ad as BannerAd;
          _adLoaded = true;
        }),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    );
    return _bannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: const Text(
          '''
        Botton banner ad.\n\n
        Banner ads occupy a spot within an app's layout, either at the top or bottom of the device screen. They stay on screen while users are interacting with the app, and can refresh automatically after a certain period of time.
        ''',
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        width: _bannerAd.size.width.toDouble(),
        height: _bannerAd.size.height.toDouble(),
        child: _adLoaded ? AdWidget(ad: _bannerAd) : LinearProgressIndicator(),
      ),
    );
  }
}
