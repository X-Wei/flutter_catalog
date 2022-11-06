import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SharePlusExample extends StatelessWidget {
  const SharePlusExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final result = await Share.shareWithResult(
              'Check out this app: https://github.com/x-wei/flutter_catalog',
              subject: 'Flutter-learning app!',
            );
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('share result=${result.status}')),
            );
          },
          icon: Icon(Icons.share),
          label: Text('Share text'),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            // We copy the logo file from assets to the app's directory.
            final dir = await getApplicationDocumentsDirectory();
            final path = '${dir.path}/logo.png';
            if (!await File(path).exists()) {
              await _copyAssetToFile('res/images/app_icon.png', path);
            }
            Share.shareXFiles([
              XFile(path),
              // !Or we can use `XFile.fromData(bytes)`
            ]);
          },
          icon: Icon(Icons.file_copy),
          label: Text('Share File'),
        ),
      ],
    );
  }

  // ! Copies an asset to local file.
  Future<void> _copyAssetToFile(String assetPath, String filePath) async {
    final data = await rootBundle.load(assetPath);
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(filePath).writeAsBytes(bytes);
  }
}
