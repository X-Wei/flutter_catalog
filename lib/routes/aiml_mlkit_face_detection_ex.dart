// ML Kit Face Detection example
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class MlkitFaceDetectionExample extends StatefulWidget {
  const MlkitFaceDetectionExample({super.key});

  @override
  State<MlkitFaceDetectionExample> createState() =>
      _MlkitFaceDetectionExampleState();
}

class _MlkitFaceDetectionExampleState extends State<MlkitFaceDetectionExample> {
  File? _imageFile;
  List<Face> _faces = [];
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
                : const Icon(Icons.face),
            label: Text(_isProcessing ? 'Processing...' : 'Detect Faces'),
          ),

          const SizedBox(height: 16),

          // Results
          if (_faces.isNotEmpty) ...[
            Text(
              'Detected Faces (${_faces.length}):',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ..._faces.asMap().entries.map(
                  (entry) => _buildFaceItem(entry.key, entry.value),
                ),
          ],
        ],
      ),
    );
  }

  Widget _buildFaceItem(int index, Face face) {
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text('Face ${index + 1}'),
        subtitle: Text('Tracking ID: ${face.trackingId ?? 'N/A'}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic info
                _buildDetailRow('Bounding Box:', '${face.boundingBox}'),
                if (face.trackingId != null)
                  _buildDetailRow('Tracking ID:', '${face.trackingId}'),

                const SizedBox(height: 8),

                // Head rotation
                if (face.headEulerAngleY != null)
                  _buildDetailRow('Head Rotation Y:', '${face.headEulerAngleY!.toStringAsFixed(1)}°'),
                if (face.headEulerAngleZ != null)
                  _buildDetailRow('Head Tilt Z:', '${face.headEulerAngleZ!.toStringAsFixed(1)}°'),

                const SizedBox(height: 8),

                // Facial expressions
                if (face.smilingProbability != null) ...[
                  _buildProbabilityRow(
                    'Smiling:',
                    face.smilingProbability!,
                    Colors.orange,
                  ),
                ],
                if (face.leftEyeOpenProbability != null) ...[
                  _buildProbabilityRow(
                    'Left Eye Open:',
                    face.leftEyeOpenProbability!,
                    Colors.blue,
                  ),
                ],
                if (face.rightEyeOpenProbability != null) ...[
                  _buildProbabilityRow(
                    'Right Eye Open:',
                    face.rightEyeOpenProbability!,
                    Colors.blue,
                  ),
                ],

                const SizedBox(height: 8),

                // Landmarks
                if (face.landmarks.isNotEmpty) ...[
                  Text(
                    'Detected Landmarks:',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  ...face.landmarks.entries.where((entry) => entry.value != null).map(
                    (entry) => _buildLandmarkRow(entry.key, entry.value!),
                  ),
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
            width: 120,
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

  Widget _buildProbabilityRow(String label, double probability, Color color) {
    final percentage = (probability * 100).round();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: probability,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 40,
                  child: Text(
                    '$percentage%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandmarkRow(FaceLandmarkType type, FaceLandmark landmark) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 2),
      child: Text(
        '• ${_getLandmarkName(type)}: ${landmark.position}',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  String _getLandmarkName(FaceLandmarkType type) {
    switch (type) {
      case FaceLandmarkType.leftEye:
        return 'Left Eye';
      case FaceLandmarkType.rightEye:
        return 'Right Eye';
      case FaceLandmarkType.leftEar:
        return 'Left Ear';
      case FaceLandmarkType.rightEar:
        return 'Right Ear';
      case FaceLandmarkType.leftCheek:
        return 'Left Cheek';
      case FaceLandmarkType.rightCheek:
        return 'Right Cheek';
      case FaceLandmarkType.noseBase:
        return 'Nose Base';
      case FaceLandmarkType.bottomMouth:
        return 'Bottom Mouth';
      case FaceLandmarkType.rightMouth:
        return 'Right Mouth';
      case FaceLandmarkType.leftMouth:
        return 'Left Mouth';
    }
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
            Icon(Icons.face_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Pick an image with faces',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Uses ML Kit Face Detection',
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
        _faces = []; // Clear previous results
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
      final options = FaceDetectorOptions(
        enableLandmarks: true,       // Detect facial landmarks
        enableClassification: true,  // Detect emotions and eye state
        enableTracking: true,        // Enable face tracking
      );
      final faceDetector = FaceDetector(options: options);
      final faces = await faceDetector.processImage(inputImage);

      setState(() {
        _faces = faces;
      });

      await faceDetector.close();
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