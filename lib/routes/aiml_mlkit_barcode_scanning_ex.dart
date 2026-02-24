// ML Kit Barcode Scanning example
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';

class MlkitBarcodeScanningExample extends StatefulWidget {
  const MlkitBarcodeScanningExample({super.key});

  @override
  State<MlkitBarcodeScanningExample> createState() =>
      _MlkitBarcodeScanningExampleState();
}

class _MlkitBarcodeScanningExampleState
    extends State<MlkitBarcodeScanningExample> {
  File? _imageFile;
  List<Barcode> _barcodes = [];
  bool _isProcessing = false;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Pick image button
          ElevatedButton.icon(
            onPressed: _isProcessing ? null : _pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Pick Image'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),

          const SizedBox(height: 16),

          // Image display and results
          Expanded(
            child: _imageFile != null
                ? _buildImageWithResults()
                : _buildPlaceholder(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWithResults() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _imageFile!,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Process button
          ElevatedButton.icon(
            onPressed: _isProcessing ? null : _processImage,
            icon: _isProcessing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.qr_code_scanner),
            label: Text(_isProcessing ? 'Processing...' : 'Scan Barcodes'),
          ),

          const SizedBox(height: 16),

          // Results
          if (_barcodes.isNotEmpty) ...[
            Text(
              'Detected Barcodes (${_barcodes.length}):',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ..._barcodes.asMap().entries.map(
                  (entry) => _buildBarcodeItem(entry.key, entry.value),
                ),
          ],
        ],
      ),
    );
  }

  Widget _buildBarcodeItem(int index, Barcode barcode) {
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          barcode.rawValue ?? 'No data',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(_getBarcodeTypeName(barcode.type)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Raw Value:', barcode.rawValue ?? 'N/A'),
                _buildDetailRow('Type:', _getBarcodeTypeName(barcode.type)),
                _buildDetailRow('Format:', _getBarcodeFormatName(barcode.format)),
                _buildDetailRow('Bounding Box:', '${barcode.boundingBox}'),
                if (barcode.cornerPoints.isNotEmpty)
                  _buildDetailRow('Corner Points:', '${barcode.cornerPoints}'),

                // Display value based on type
                if (barcode.type == BarcodeType.url && barcode.rawValue != null) ...[
                  const SizedBox(height: 8),
                  _buildDetailRow('URL:', barcode.rawValue!),
                ],
                if (barcode.type == BarcodeType.wifi && barcode.rawValue != null) ...[
                  const SizedBox(height: 8),
                  _buildDetailRow('WiFi Info:', barcode.rawValue!),
                ],
                if (barcode.type == BarcodeType.email && barcode.rawValue != null) ...[
                  const SizedBox(height: 8),
                  _buildDetailRow('Email:', barcode.rawValue!),
                ],
                if (barcode.type == BarcodeType.phone && barcode.rawValue != null) ...[
                  const SizedBox(height: 8),
                  _buildDetailRow('Phone:', barcode.rawValue!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Pick an image with barcodes',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Uses ML Kit Barcode Scanning',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  String _getBarcodeTypeName(BarcodeType type) {
    switch (type) {
      case BarcodeType.wifi:
        return 'WiFi';
      case BarcodeType.url:
        return 'URL';
      case BarcodeType.email:
        return 'Email';
      case BarcodeType.phone:
        return 'Phone';
      case BarcodeType.sms:
        return 'SMS';
      case BarcodeType.text:
        return 'Text';
      case BarcodeType.unknown:
        return 'Unknown';
      case BarcodeType.contactInfo:
        return 'Contact';
      case BarcodeType.calendarEvent:
        return 'Calendar';
      case BarcodeType.driverLicense:
        return 'Driver License';
      case BarcodeType.geoCoordinates:
        return 'Geo Coordinates';
      case BarcodeType.isbn:
        return 'ISBN';
      case BarcodeType.product:
        return 'Product';
    }
  }

  String _getBarcodeFormatName(BarcodeFormat format) {
    return format.name.toUpperCase();
  }

  Future<void> _pickImage() async {
    final source = await _showImageSourceDialog();
    if (source == null) return;

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _barcodes = []; // Clear previous results
      });
    }
  }

  Future<void> _processImage() async {
    if (_imageFile == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final inputImage = InputImage.fromFile(_imageFile!);
      final barcodeScanner = BarcodeScanner();
      final barcodes = await barcodeScanner.processImage(inputImage);

      setState(() {
        _barcodes = barcodes;
      });

      await barcodeScanner.close();
    } catch (e) {
      _showMessage('Error processing image: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}