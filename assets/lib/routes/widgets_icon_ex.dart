import 'package:flutter/material.dart';

class IconExample extends StatelessWidget {
  const IconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.image,
        size: 64.0,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
