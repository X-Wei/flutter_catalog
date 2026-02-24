// ML Kit Text Recognition example
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class MlkitTextRecognitionExample extends StatefulWidget {
  const MlkitTextRecognitionExample({super.key});

  @override
  State<MlkitTextRecognitionExample> createState() =>
      _MlkitTextRecognitionExampleState();
}

class _MlkitTextRecognitionExampleState
    extends State<MlkitTextRecognitionExample> {
  File? _imageFile;
  RecognizedText? _recognizedText;
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
                : const Icon(Icons.text_fields),
            label: Text(_isProcessing ? 'Processing...' : 'Extract Text'),
          ),

          const SizedBox(height: 16),

          // Results
          if (_recognizedText != null) ...[
            Text(
              'Extracted Text:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            // Full text
            if (_recognizedText!.text.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  _recognizedText!.text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Text blocks details
            Text(
              'Text Blocks (${_recognizedText!.blocks.length}):',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            ..._recognizedText!.blocks.asMap().entries.map(
                  (entry) => _buildTextBlockItem(entry.key, entry.value),
                ),
          ],
        ],
      ),
    );
  }

  Widget _buildTextBlockItem(int index, TextBlock block) {
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          child: Text('${index + 1}'),
        ),
        title: Text(
          block.text.length > 50
              ? '${block.text.substring(0, 50)}...'
              : block.text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('Languages: ${block.recognizedLanguages.join(', ')}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Full text:', style: Theme.of(context).textTheme.labelMedium),
                Text(block.text),
                const SizedBox(height: 8),
                Text('Bounding box:', style: Theme.of(context).textTheme.labelMedium),
                Text('${block.boundingBox}'),
                const SizedBox(height: 8),
                Text('Corner points:', style: Theme.of(context).textTheme.labelMedium),
                Text('${block.cornerPoints}'),
              ],
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
            Icon(Icons.text_fields_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Pick an image with text',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Uses ML Kit Text Recognition',
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
        _recognizedText = null; // Clear previous results
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
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await textRecognizer.processImage(inputImage);

      setState(() {
        _recognizedText = recognizedText;
      });

      await textRecognizer.close();
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