import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../my_route.dart';

class ImagePickerExample extends MyRoute {
  const ImagePickerExample(
      [String sourceFile = 'lib/routes/plugins_image_picker_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Image Picker';

  @override
  get description => 'Pick image from gallery or from camera.';

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _ImagePickerDemo(),
    );
  }
}

class _ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<_ImagePickerDemo> {
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ButtonBar(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () async => await _pickImageFromCamera(),
              tooltip: 'Shoot picture',
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () async => await _pickImageFromGallery(),
              tooltip: 'Pick from gallery',
            ),
          ],
        ),
        this._imageFile == null ? Placeholder() : Image.file(this._imageFile),
      ],
    );
  }

  Future<Null> _pickImageFromGallery() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() => this._imageFile = imageFile);
  }

  Future<Null> _pickImageFromCamera() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => this._imageFile = imageFile);
  }
}
