import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image_pkg;

class ImagePluginExample extends StatelessWidget {
  const ImagePluginExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImgBytes(),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasData) {
          final newImgBytes = manipulateImage(snapshot.data);
          return Center(child: Image.memory(newImgBytes));
        } else {
          return const Center(
            child: LinearProgressIndicator(),
          );
        }
      },
    );
  }

  Uint8List manipulateImage(Uint8List pngData) {
    final img = image_pkg.readPng(pngData);
    image_pkg.drawString(
      img,
      /*font=*/ image_pkg.arial_48,
      /*x=*/ 200,
      /*y=*/ 100,
      'Hello word!\nThis stirng is drawn using the image plugin.',
      color: image_pkg.getColor(0, 0, 255),
    );
    image_pkg.drawLine(
      img,
      /*x1=*/ 0,
      /*y1=*/ 0,
      /*x2=*/ 320,
      /*y2=*/ 240,
      image_pkg.getColor(255, 0, 0),
      thickness: 3,
    );

    return Uint8List.fromList(image_pkg.encodePng(img));
  }

  Future<Uint8List> getImgBytes() async {
    final bytes = await rootBundle.load('res/images/dart-side.png');
    return bytes.buffer.asUint8List();
  }
}
