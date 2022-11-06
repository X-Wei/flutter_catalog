import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class InAppReviewExample extends StatelessWidget {
  const InAppReviewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Text('The following triggers the In-App Review prompt.\n'
            'This should NOT be used frequently as the underlying APIs '
            'enforce strict quotas on this feature to provide a great user experience.'),
        ElevatedButton.icon(
          onPressed: () async {
            if (await InAppReview.instance.isAvailable()) {
              InAppReview.instance.requestReview();
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Review unavailable'),
                  content: const Text(
                      'The device is unable to show a review dialog!'),
                ),
              );
            }
          },
          icon: Icon(Icons.thumbs_up_down),
          label: Text('Open ratings dialog'),
        ),
        Divider(),
        Text('The following opens the Google Play Store on Android, '
            'the App Store with a review screen on IOS & MacOS '
            'and the Microsoft Store on Windows.\n'
            'Use this if you want to permanently provide a button or other call-to-action '
            'to let users leave a review as it is NOT RESTRICED by a quota.'),
        ElevatedButton.icon(
          onPressed: () {
            InAppReview.instance.openStoreListing(
              // appStoreId is only required on IOS and MacOS
              // can be found in App Store Connect under General > App Information > Apple ID.
              appStoreId: '1602928862',
              microsoftStoreId: null,
            );
          },
          icon: Icon(Icons.open_in_new),
          label: Text('Open in store'),
        ),
      ],
    );
  }
}
