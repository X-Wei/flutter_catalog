import 'package:flutter/material.dart';

class WrapExample extends StatelessWidget {
  const WrapExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // Gap between adjacent chips.
      spacing: 8.0,
      // Gap between lines.
      runSpacing: 4.0,
      children: [
        'Cauchy',
        'Fourrier',
        'Lagrange',
        'Lebesgue',
        'Levy',
        'Poisson',
        'Pointcare',
      ]
          .map(
            (String name) => Chip(
              avatar: CircleAvatar(child: Text(name.substring(0, 1))),
              label: Text(name),
            ),
          )
          .toList(),
    );
  }
}
