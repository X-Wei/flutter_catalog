import 'package:flutter/material.dart';
import '../my_route.dart';

class ImageExample extends MyRoute {
  const ImageExample([String sourceFile = 'lib/routes/widgets_image_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Image';

  @override
  get links =>
      {'Doc': 'https://docs.flutter.io/flutter/widgets/Image-class.html'};

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: Image.asset('res/images/material_design_2.jpg'),
        ),
        Card(
          child: Image.network(
              'https://images.freeimages.com/images/large-previews/4ad/coloured-pencils-1427682.jpg'),
        ),
      ],
    );
  }
}
