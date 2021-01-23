import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerExample extends StatelessWidget {
  const ShimmerExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Shimmer.fromColors(
          // enabled: true,
          baseColor: Colors.grey[400],
          highlightColor: Colors.grey[100],
          child: const ListTile(
            title: Text('Slide to unlock'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        const Divider(),
        Shimmer.fromColors(
          // enabled: true,
          baseColor: Colors.grey[400],
          highlightColor: Colors.grey[100],
          child: ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: placeHolderRow(),
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 2),
          ),
        ),
      ],
    );
  }

  // Some white boxes to indicate a placeholder for contents to come.
  // Copied from https://pub.dev/packages/shimmer/example
  Widget placeHolderRow() =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 48.0,
          height: 48.0,
          color: Colors.white,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 8.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
              ),
              Container(
                width: double.infinity,
                height: 8.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
              ),
              Container(
                width: 40.0,
                height: 8.0,
                color: Colors.white,
              ),
            ],
          ),
        )
      ]);
}
