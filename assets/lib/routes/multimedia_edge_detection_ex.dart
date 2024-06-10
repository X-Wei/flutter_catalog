import 'dart:io';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class EdgeDetectionExample extends StatefulWidget {
  const EdgeDetectionExample({super.key});

  @override
  _EdgeDetectionExampleState createState() => _EdgeDetectionExampleState();
}

class _EdgeDetectionExampleState extends State<EdgeDetectionExample> {
  String? _scannedImgPath;
  String? _error;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.camera),
          label: const Text('start'),
          onPressed: _doScan,
        ),
        if (_scannedImgPath != null) ...[
          Text(_scannedImgPath!),
          Expanded(
            child: Image.file(File(_scannedImgPath!)),
          )
        ],
        if (_error != null) Text(_error!),
      ],
    );
  }

  Future<void> _doScan() async {
    // Generate filepath for saving
    final imgPath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
    try {
      //Make sure to await the call to detectEdge.
      final success = await EdgeDetection.detectEdge(
        /*saveTo=*/ imgPath,
        canUseGallery: true,
      );
      if (success) {
        setState(() => _scannedImgPath = imgPath);
      } else {
        setState(
            () => _error = 'detectEdge() returned false, something went wrong');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }
}
