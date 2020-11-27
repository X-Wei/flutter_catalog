import 'package:flutter/material.dart';

class FractionallySizedBoxExample extends StatelessWidget {
  const FractionallySizedBoxExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 20),
        Text('Fractionally sized box sizes its child to a fraction of the '
            'total available space.'),
        Text(
            'To use it inside a column or a row, wrap it in a Flexible widget'),
        Text('FractionallySizedBox with no child serves as whitespace. '
            'The whitespace below always takes 10% of the available height'),
        Flexible(child: FractionallySizedBox(heightFactor: 0.1)),
        Text(
            'The placeholder below always takes 20% of the available height and 50% of the width.\n'),
        Flexible(
          child: FractionallySizedBox(
            heightFactor: 0.2,
            widthFactor: 0.5,
            child: Placeholder(),
          ),
        ),
      ],
    );
  }
}
