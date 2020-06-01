import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({Key key}) : super(key: key);

  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File _imageFile;
  final _picker = ImagePicker();

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
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() => this._imageFile = File(pickedFile.path));
  }

  Future<Null> _pickImageFromCamera() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    setState(() => this._imageFile = File(pickedFile.path));
  }
}
