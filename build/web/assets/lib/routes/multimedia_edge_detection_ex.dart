import 'dart:io';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';

class EdgeDetectionExample extends StatefulWidget {
  const EdgeDetectionExample({Key key}) : super(key: key);

  @override
  _EdgeDetectionExampleState createState() => _EdgeDetectionExampleState();
}

class _EdgeDetectionExampleState extends State<EdgeDetectionExample> {
  String _scannedImgPath;
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
          Text(_scannedImgPath),
          Expanded(
            child: Image.file(File(_scannedImgPath)),
          )
        ]
      ],
    );
  }

  Future<void> _doScan() async {
    /// This [detectEdge] is the only method exposed by the plugin, it'll open
    /// the camera and do the scanning.
    /// !Unfortunately we cannot customize the behavior like loading image from
    /// !gallery or changing the saved image path.
    final imgPath = await EdgeDetection.detectEdge;
    setState(() => _scannedImgPath = imgPath);
  }
}
