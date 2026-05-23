// ML Kit Document Scanner example
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

class MlkitDocScannerExample extends StatefulWidget {
  const MlkitDocScannerExample({super.key});

  @override
  State<MlkitDocScannerExample> createState() => _MlkitDocScannerExampleState();
}

class _MlkitDocScannerExampleState extends State<MlkitDocScannerExample> {
  String? _imagePath;
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Scan button
          ElevatedButton.icon(
            onPressed: _isScanning ? null : _scanDocument,
            icon: _isScanning
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.document_scanner),
            label: Text(_isScanning ? 'Scanning...' : 'Scan Document'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),

          const SizedBox(height: 24),

          // Scanned image display
          Expanded(
            child: _imagePath != null
                ? _buildScannedImage()
                : _buildPlaceholder(),
          ),

          // Clear button
          if (_imagePath != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => setState(() => _imagePath = null),
              icon: const Icon(Icons.clear),
              label: const Text('Clear'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScannedImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scanned Document:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(_imagePath!),
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'File: ${_imagePath!.split('/').last}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.document_scanner_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Tap "Scan Document" to get started',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Uses ML Kit Document Scanner API',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scanDocument() async {
    setState(() {
      _isScanning = true;
    });

    try {
      // Configure scanner options
      final options = DocumentScannerOptions(
        mode: ScannerMode.full, // Full scanner UI
        isGalleryImport: true, // Allow importing from gallery
        pageLimit: 1, // Limit to 1 page for simplicity
      );

      // Create scanner and scan document
      final scanner = DocumentScanner(options: options);
      final result = await scanner.scanDocument();

      // Handle scan result
      final images = result.images;
      if (images != null && images.isNotEmpty) {
        setState(() {
          _imagePath = images.first;
        });
      } else {
        _showMessage('No document was scanned');
      }
    } catch (e) {
      _showMessage('Error: $e');
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  void _showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
