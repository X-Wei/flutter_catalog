import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewordedAdExample extends StatefulWidget {
  const RewordedAdExample({super.key});

  @override
  State<RewordedAdExample> createState() => _RewordedAdExampleState();
}

class _RewordedAdExampleState extends State<RewordedAdExample> {
  RewardedAd? _rewardedAd;
  static const _kMaxLoadAdRetries = 3;
  int _loadAdAttempts = 0;

  String get _kAdUnitId {
    // ! Return test ad unit if we are in debug mode -- otherwise account might be banned!
    if (Platform.isAndroid) {
      return kDebugMode
          // https://developers.google.com/admob/android/test-ads#sample_ad_units
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-7906158617398863/7948862610';
    } else if (Platform.isIOS) {
      return kDebugMode
          // https://developers.google.com/admob/ios/test-ads#demo_ad_units
          ? 'ca-app-pub-3940256099942544/1712485313'
          : 'ca-app-pub-7906158617398863/5990528080';
    }
    return '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: _kAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          setState(() {});
          _loadAdAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _loadAdAttempts += 1;
          _rewardedAd = null;
          setState(() {});
          if (_loadAdAttempts <= _kMaxLoadAdRetries) {
            _loadRewardedAd();
          }
        },
      ),
    );
  }

  Future<bool> _showRewardedAd() async {
    if (_rewardedAd == null) {
      return false;
    } else {
      // Listen for lifecycle events, such as when the ad is shown or dismissed.
      // Set this before showing the ad to receive notifications for these events.
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          _loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          _loadRewardedAd();
        },
      );
      await _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          if (mounted) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('🎉Reward obtained!'),
                content: Text(
                  // The reward amount/type are defined in admob console.
                  'Great! You have now rewarded ${reward.amount} unit of "${reward.type}"!',
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))
                ],
              ),
            );
          }
        },
      );
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _rewardedAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Text(
          '''
          Rewarded ad.\n
          Rewarded ads are ads that users have the option of interacting with in exchange for in-app rewards.
          ''',
        ),
        SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: _rewardedAd == null
              ? null
              : () async {
                  final adShown = await _showRewardedAd();
                  if (!adShown && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Ad not displayed, please retry!')),
                    );
                  }
                },
          icon: _rewardedAd == null
              ? CircularProgressIndicator()
              : Icon(Icons.emoji_events),
          label: Text('Click to show ad'),
        ),
      ],
    );
  }
}
