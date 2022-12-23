import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'feature_store_secrets.dart';
import 'monetization_user_purchases_ex.dart';

class InlineBannerAdExample extends StatelessWidget {
  const InlineBannerAdExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '''
          Inline banners\n\n

          Adaptive banners are the next generation of responsive ads, maximizing performance by optimizing ad size for each device. Improving on fixed-size banners, which only supported fixed heights, adaptive banners let developers specify the ad-width and use this to determine the optimal ad size.
          ''',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, idx) {
              final content =
                  ListTile(title: Text('App content - item "${idx + 1}"'));
              if ((idx + 1) % 5 == 0) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    content,
                    MyBannerAdWidget(
                        placeholder: Placeholder(fallbackHeight: 32)),
                  ],
                );
              }
              return content;
            },
            itemCount: 100,
          ),
        ),
      ],
    );
  }
}

/// !Create a statefulWidget to repr the inline banner.
/// Otherwise we can't show the same ad twice in the UI.
/// See https://stackoverflow.com/a/71899578/12421326.
class MyBannerAdWidget extends StatefulWidget {
  final Widget placeholder;
  const MyBannerAdWidget({this.placeholder = const SizedBox()});

  @override
  State<MyBannerAdWidget> createState() => _MyBannerAdWidgetState();
}

class _MyBannerAdWidgetState extends State<MyBannerAdWidget> {
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
    if (_bannerAd != null && _adLoaded) {
      return Container(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        alignment: Alignment.center,
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      return widget.placeholder;
    }
  }
}

/// ! Hides the banner ad if user purchased the "RemoveAd" item.
class MyBannerAd extends ConsumerWidget {
  const MyBannerAd({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adRemoved = ref.watch(adIsRemovedProvider);
    if (adRemoved) {
      return Container();
    }
    return MyBannerAdWidget();
  }
}
