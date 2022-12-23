import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'feature_store_secrets.dart';
import 'monetization_user_purchases_ex.dart';

class RewordedAdExample extends ConsumerStatefulWidget {
  const RewordedAdExample({super.key});

  @override
  ConsumerState<RewordedAdExample> createState() => _RewordedAdExampleState();
}

class _RewordedAdExampleState extends ConsumerState<RewordedAdExample> {
  RewardedAd? _rewardedAd;
  static const _kMaxLoadAdRetries = 3;
  int _loadAdAttempts = 0;
  bool _personalizeAds = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: MySecretsHelper.rewardedAdUnitId,
      request: AdRequest(nonPersonalizedAds: !_personalizeAds),
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
            //! See monetization_user_purchases_ex.dart
            addCoins(ref, reward.amount.toInt());
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
        SwitchListTile.adaptive(
          title: Text('Personalized Ads'),
          value: _personalizeAds,
          onChanged: (p) => setState(() {
            _personalizeAds = p;
            _loadAdAttempts = 0;
            _rewardedAd = null;
            _loadRewardedAd();
          }),
        ),
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
        SizedBox(height: 32),
        Text(
          '💰 You currently have ${ref.watch(userCoinsProvider)} coins.',
          style: Theme.of(context).textTheme.headline6,
        ),
        //! See monetization_user_purchases_ex.dart
        buildUserBanner(context, ref),
      ],
    );
  }
}
