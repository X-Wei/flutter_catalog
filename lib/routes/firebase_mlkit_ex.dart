import 'dart:io';
import 'dart:math';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart'
    show kTransparentImage;
import 'package:flutter/material.dart';
import '../my_route.dart';

// NOTE: to add firebase support, first go to firebase console, generate the
// firebase json file, and add configuration lines in the gradle files.
// C.f. this commit: https://github.com/X-Wei/flutter_catalog/commit/48792cbc0de62fc47e0e9ba2cd3718117f4d73d1.
class FirebaseMLKitExample extends MyRoute {
  const FirebaseMLKitExample(
      [String sourceFile = 'lib/routes/firebase_mlkit_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Firebase ML Kit';

  @override
  get description => 'Image labelling, text OCR, barcode scan, face detection.';

  @override
  get links => {
        'Doc': 'https://pub.dartlang.org/packages/firebase_ml_vision',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MLKitDemoPage(),
    );
  }
}

// Adapted from the flutter firestore "babyname voter" codelab:
// https://codelabs.developers.google.com/codelabs/flutter-firebase/#0
class MLKitDemoPage extends StatefulWidget {
  @override
  _MLKitDemoPageState createState() => _MLKitDemoPageState();
}

class _MLKitDemoPageState extends State<MLKitDemoPage> {
  File _imageFile;
  String _mlResult = '<no result>';

  Future<bool> _pickImage() async {
    setState(() => this._imageFile = null);
    final File imageFile = await showDialog<File>(
      context: context,
      builder: (ctx) => SimpleDialog(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take picture'),
                onTap: () async {
                  final File imageFile =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  Navigator.pop(ctx, imageFile);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Pick from gallery'),
                onTap: () async {
                  try {
                    final File imageFile = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    Navigator.pop(ctx, imageFile);
                  } catch (e) {
                    print(e);
                    Navigator.pop(ctx, null);
                  }
                },
              ),
            ],
          ),
    );
    if (imageFile == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Please pick one image first.')),
      );
      return false;
    }
    setState(() => this._imageFile = imageFile);
    print('picked image: ${this._imageFile}');
    return true;
  }

  Future<Null> _imageLabelling() async {
    setState(() => this._mlResult = '<no result>');
    if (await _pickImage() == false) {
      return;
    }
    String result = '';
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(this._imageFile);
    final LabelDetector labelDetector = FirebaseVision.instance.labelDetector();
    final List<Label> labels = await labelDetector.detectInImage(visionImage);
    result += 'Detected ${labels.length} labels.\n';
    for (Label label in labels) {
      final String text = label.label;
      final String entityId = label.entityId;
      final double confidence = label.confidence;
      result +=
          '\n#Label: $text($entityId), confidence=${confidence.toStringAsFixed(3)}';
    }
    if (result.length > 0) {
      setState(() => this._mlResult = result);
    }
  }

  Future<Null> _textOcr() async {
    setState(() => this._mlResult = '<no result>');
    if (await _pickImage() == false) {
      return;
    }
    String result = '';
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(this._imageFile);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    final String text = visionText.text;
    result += 'Detected ${visionText.blocks.length} text blocks.\n';
    for (TextBlock block in visionText.blocks) {
      final Rectangle<int> boundingBox = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;
      result += '\n# Text block:\n '
          'bbox=$boundingBox\n '
          'cornerPoints=$cornerPoints\n '
          'text=$text\n languages=$languages';
      // for (TextLine line in block.lines) {
      //   // Same getters as TextBlock
      //   for (TextElement element in line.elements) {
      //     // Same getters as TextBlock
      //   }
      // }
    }
    if (result.length > 0) {
      setState(() => this._mlResult = result);
    }
  }

  Future<Null> _barcodeScan() async {
    setState(() => this._mlResult = '<no result>');
    if (await _pickImage() == false) {
      return;
    }
    String result = '';
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(this._imageFile);
    final BarcodeDetector barcodeDetector =
        FirebaseVision.instance.barcodeDetector();

    final List<Barcode> barcodes =
        await barcodeDetector.detectInImage(visionImage);
    result += 'Detected ${barcodes.length} barcodes.\n';
    for (Barcode barcode in barcodes) {
      final Rectangle<int> boundingBox = barcode.boundingBox;
      final List<Point<int>> cornerPoints = barcode.cornerPoints;

      final String rawValue = barcode.rawValue;
      final valueType = barcode.valueType;
      result += '\n# Barcode:\n '
          'bbox=$boundingBox\n '
          'cornerPoints=$cornerPoints\n '
          'rawValue=$rawValue\n '
          'vlaueType=$valueType';
      // // See API reference for complete list of supported types
      // switch (valueType) {
      //   case BarcodeValueType.wifi:
      //     final String ssid = barcode.wifi.ssid;
      //     final String password = barcode.wifi.password;
      //     final BarcodeWiFiEncryptionType type = barcode.wifi.encryptionType;
      //     break;
      //   case BarcodeValueType.url:
      //     final String title = barcode.url.title;
      //     final String url = barcode.url.url;
      //     break;
      //   default:
      //     break;
      // }
    }
    if (result.length > 0) {
      setState(() => this._mlResult = result);
    }
  }

  Future<Null> _faceDetect() async {
    setState(() => this._mlResult = '<no result>');
    if (await _pickImage() == false) {
      return;
    }
    String result = '';
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(this._imageFile);
    final options = FaceDetectorOptions(
      enableLandmarks: true,
      enableClassification: true,
      enableTracking: true,
    );
    final FaceDetector faceDetector =
        FirebaseVision.instance.faceDetector(options);
    final List<Face> faces = await faceDetector.detectInImage(visionImage);
    result += 'Detected ${faces.length} faces.\n';
    for (Face face in faces) {
      final Rectangle<int> boundingBox = face.boundingBox;
      // Head is rotated to the right rotY degrees
      final double rotY = face.headEulerAngleY;
      // Head is tilted sideways rotZ degrees
      final double rotZ = face.headEulerAngleZ;
      result += '\n# Face:\n '
          'bbox=$boundingBox\n '
          'rotY=$rotY\n '
          'rotZ=$rotZ\n ';
      // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
      // eyes, cheeks, and nose available):
      final FaceLandmark leftEar = face.getLandmark(FaceLandmarkType.leftEar);
      if (leftEar != null) {
        final Point<double> leftEarPos = leftEar.position;
        result += 'leftEarPos=$leftEarPos\n ';
      }
      // If classification was enabled with FaceDetectorOptions:
      if (face.smilingProbability != null) {
        final double smileProb = face.smilingProbability;
        result += 'smileProb=${smileProb.toStringAsFixed(3)}\n ';
      }
      // If face tracking was enabled with FaceDetectorOptions:
      if (face.trackingId != null) {
        final int id = face.trackingId;
        result += 'id=$id\n ';
      }
    }
    if (result.length > 0) {
      setState(() => this._mlResult = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        this._imageFile == null
            ? Placeholder(
                fallbackHeight: 200.0,
              )
            : FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: FileImage(this._imageFile),
                // Image.file(, fit: BoxFit.contain),
              ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: Text('Image Labelling'),
                onPressed: this._imageLabelling,
              ),
              RaisedButton(
                child: Text('Text OCR'),
                onPressed: this._textOcr,
              ),
              RaisedButton(
                child: Text('Barcode Scan'),
                onPressed: this._barcodeScan,
              ),
              RaisedButton(
                child: Text('Face Detection'),
                onPressed: this._faceDetect,
              ),
            ],
          ),
        ),
        Divider(),
        Text('Result:', style: Theme.of(context).textTheme.subtitle),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            this._mlResult,
            style: TextStyle(fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }
}
