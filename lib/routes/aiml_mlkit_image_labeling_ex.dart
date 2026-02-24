// ML Kit Image Labeling example
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

class MlkitImageLabelingExample extends StatefulWidget {
  const MlkitImageLabelingExample({super.key});

  @override
  State<MlkitImageLabelingExample> createState() =>
      _MlkitImageLabelingExampleState();
}

class _MlkitImageLabelingExampleState extends State<MlkitImageLabelingExample> {
  File? _imageFile;
  List<ImageLabel> _labels = [];
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
                : const Icon(Icons.auto_awesome),
            label: Text(_isProcessing ? 'Processing...' : 'Analyze Image'),
          ),

          const SizedBox(height: 16),

          // Results
          if (_labels.isNotEmpty) ...[
            Text(
              'Detected Labels (${_labels.length}):',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ..._labels.map((label) => _buildLabelItem(label)),
          ],
        ],
      ),
    );
  }

  Widget _buildLabelItem(ImageLabel label) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${(label.confidence * 100).round()}%'),
        ),
        title: Text(label.label),
        subtitle: Text('Confidence: ${label.confidence.toStringAsFixed(3)}'),
        trailing: Text('#${label.index}'),
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
            Icon(Icons.image_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Pick an image to analyze',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Uses ML Kit Image Labeling',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final source = await _showImageSourceDialog();
    if (source == null) return;

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _labels = []; // Clear previous results
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
      final imageLabeler = ImageLabeler(options: ImageLabelerOptions());
      final labels = await imageLabeler.processImage(inputImage);

      setState(() {
        _labels = labels;
      });

      await imageLabeler.close();
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