import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'firebase_flutterfire_loginui_ex.dart';
import 'monetization_user_purchases_ex.dart';

class InAppPurchaseExample extends ConsumerStatefulWidget {
  const InAppPurchaseExample({super.key});

  @override
  ConsumerState<InAppPurchaseExample> createState() =>
      _InAppPurchaseExampleState();
}

class _InAppPurchaseExampleState extends ConsumerState<InAppPurchaseExample> {
  final _iap = InAppPurchase.instance;
  bool _available = true; // Whether IAP is available
  List<ProductDetails> _products = [];
  final List<PurchaseDetails> _purchases = [];
  late StreamSubscription _subscription;
  // ! Those product ids are configured on the playstore.
  static const _p10coins = '10_coins', _pRemoveAds = 'remove_ads';
  final _ids = {_p10coins, _pRemoveAds};

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _available = await _iap.isAvailable();
    if (!_available) return;
    setState(() {});
    // get products.
    final resp = await _iap.queryProductDetails(_ids);
    _products = resp.productDetails;
    setState(() {});
    // subscribe to purchase stream.
    _subscription = _iap.purchaseStream.listen((data) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('NEW PURCHASE: $data'),
        ),
      );
      debugPrint('NEW PURCHASE');
      for (final p in data) {
        debugPrint(p.toString());
        if (p.productID == _p10coins) {
          //! See monetization_user_purchases_ex.dart
          addCoins(ref, 10);
        } else if (p.productID == _pRemoveAds) {
          //! See monetization_user_purchases_ex.dart
          setRemoveAds(ref, true);
        }
      }
      _purchases.addAll(data);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _purchaseItem(ProductDetails prod) async {
    if (ref.read(currentUserProvider) == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Log in required'),
          content: const Text('You must first log in to purchase items.\n'
              'Tap the bottom card to go to log in page.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            )
          ],
        ),
      );
      return;
    }
    final pp = PurchaseParam(productDetails: prod);
    await _iap.buyConsumable(purchaseParam: pp, autoConsume: false);
  }

  @override
  Widget build(BuildContext context) {
    if (!_available) {
      return Center(child: Text('❌️ IAP is not available!'));
    }
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // !Products
          for (final prod in _products) ...[
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text(prod.title),
              subtitle: Text(prod.description),
            ),
            ElevatedButton(
              onPressed: () => _purchaseItem(prod),
              child: Text('Buy with ${prod.price}'),
            ),
            Divider(),
          ],
          // ! user-purchase
          ListTile(
            leading: Icon(Icons.list),
            title: Text('You can check your purchase status in the other page'),
            subtitle: Text('Tap here to go to the purchase-details page.'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.of(context)
                .pushNamed('/monetization_user_purchases_ex'),
          ),
          // !Purchases
          if (_purchases.isNotEmpty) ...[
            Divider(),
            Text('Purchases', style: Theme.of(context).textTheme.headline6),
            for (final p in _purchases)
              Card(
                child: Text(
                  'productID=${p.productID}\n'
                  'purchaseID=${p.purchaseID}\n'
                  'status=${p.status}\n'
                  'pendingCompletePurchase=${p.pendingCompletePurchase}\n',
                ),
              )
          ]
        ],
      ),
      //! See monetization_user_purchases_ex.dart
      bottomNavigationBar: buildUserBanner(context, ref),
    );
  }
}
