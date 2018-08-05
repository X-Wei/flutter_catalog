import 'package:flutter/material.dart';
import '../my_route.dart';

class IconExample extends MyRoute {
  const IconExample([String sourceFile = 'lib/routes/widgets_icon_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Icon';

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Center(
      child: Icon(
        Icons.image,
        size: 64.0,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
