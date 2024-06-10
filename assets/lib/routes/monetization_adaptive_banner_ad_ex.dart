import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'feature_store_secrets.dart';

class AnchoredAdaptiveBannerAdExample extends StatefulWidget {
  const AnchoredAdaptiveBannerAdExample({super.key});

  @override
  State<AnchoredAdaptiveBannerAdExample> createState() =>
      _AnchoredAdaptiveBannerAdExampleState();
}

class _AnchoredAdaptiveBannerAdExampleState
    extends State<AnchoredAdaptiveBannerAdExample> {
  bool _adLoaded = false;
  BannerAd? _bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    //! Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }
    _bannerAd = BannerAd(
      adUnitId: MySecretsHelper.bannerAdUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => setState(() {
          _bannerAd = ad as BannerAd;
          _adLoaded = true;
        }),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    );
    return _bannerAd?.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: const SelectableText(
          '''
        Anchored adaptive banners\n\n

        Adaptive banners are the next generation of responsive ads, maximizing performance by optimizing ad size for each device. Improving on smart banners, which supported only fixed heights, adaptive banners let you specify the ad width and use this to determine the optimal ad size.

        To choose the best ad size, adaptive banners use fixed aspect ratios instead of fixed heights. This results in banner ads that occupy a more consistent portion of the screen across devices and provides opportunities for improved performance.

        Banner ads occupy a spot within an app's layout, either at the top or bottom of the device screen. They stay on screen while users are interacting with the app, and can refresh automatically after a certain period of time.
        ''',
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        width: _bannerAd?.size.width.toDouble() ?? double.infinity,
        height: _bannerAd?.size.height.toDouble() ?? 32,
        child: _bannerAd != null && _adLoaded
            ? AdWidget(ad: _bannerAd!)
            : LinearProgressIndicator(),
      ),
    );
  }
}
