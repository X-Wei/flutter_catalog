import 'package:flutter/material.dart';

class TypographyExample extends StatelessWidget {
  const TypographyExample({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final _styles = <String, TextStyle>{
      'headline1': textTheme.headline1!,
      'headline2': textTheme.headline2!,
      'headline3': textTheme.headline3!,
      'headline4': textTheme.headline4!,
      'headline5': textTheme.headline5!,
      'headline6': textTheme.headline6!,
      'subtitle1': textTheme.subtitle1!,
      'subtitle2': textTheme.subtitle2!,
      'bodyText1': textTheme.bodyText1!,
      'bodyText2': textTheme.bodyText2!,
      'button': textTheme.button!,
      'caption': textTheme.caption!,
      'overline': textTheme.overline!,
    };
    return ListView(
      children: [
        for (final e in _styles.entries)
          ListTile(title: Text(e.key, style: e.value)),
      ],
    );
  }
}
