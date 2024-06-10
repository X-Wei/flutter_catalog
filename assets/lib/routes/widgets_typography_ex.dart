import 'package:flutter/material.dart';

class TypographyExample extends StatelessWidget {
  const TypographyExample({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final _styles = <String, TextStyle>{
      'headline1': textTheme.displayLarge!,
      'headline2': textTheme.displayMedium!,
      'headline3': textTheme.displaySmall!,
      'headline4': textTheme.headlineMedium!,
      'headline5': textTheme.headlineSmall!,
      'headline6': textTheme.titleLarge!,
      'subtitle1': textTheme.titleMedium!,
      'subtitle2': textTheme.titleSmall!,
      'bodyText1': textTheme.bodyLarge!,
      'bodyText2': textTheme.bodyMedium!,
      'button': textTheme.labelLarge!,
      'caption': textTheme.bodySmall!,
      'overline': textTheme.labelSmall!,
    };
    return ListView(
      children: [
        for (final e in _styles.entries)
          ListTile(title: Text(e.key, style: e.value)),
      ],
    );
  }
}
