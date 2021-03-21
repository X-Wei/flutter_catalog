import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

const _kTexts = ['你好!', 'Hello!', 'Bonjour!', 'Hallo!', 'Grützi!'];
const _kTextStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  color: Colors.blueAccent,
);

class AnimatedTextKitExample extends StatelessWidget {
  const AnimatedTextKitExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.headline5;
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Text('TextLiquidFill', style: titleTextStyle),
        TextLiquidFill(
          text: 'LIQUIDY',
          waveColor: Colors.blueAccent,
          boxBackgroundColor: Colors.red[100],
          textStyle:
              const TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
          boxHeight: 300.0,
        ),
        Divider(),
        Text('RotateAnimatedTextKit', style: titleTextStyle),
        SizedBox(
          height: 64,
          child: RotateAnimatedTextKit(
            onTap: () => print("Tap Event"),
            text: _kTexts,
            repeatForever: true,
            textStyle: _kTextStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Divider(),
        Text('TypewriterAnimatedTextKit', style: titleTextStyle),
        TypewriterAnimatedTextKit(
          text: _kTexts,
          textStyle: _kTextStyle,
          textAlign: TextAlign.start,
        ),
        Divider(),
        Text('FadeAnimatedTextKit', style: titleTextStyle),
        SizedBox(
          height: 64,
          child: FadeAnimatedTextKit(
            onTap: () => print("Tap Event"),
            text: _kTexts,
            repeatForever: true,
            textStyle: _kTextStyle,
          ),
        ),
        Divider(),
        Text('TyperAnimatedTextKit', style: titleTextStyle),
        TyperAnimatedTextKit(
          onTap: () => print("Tap Event"),
          text: _kTexts,
          textStyle: _kTextStyle,
          textAlign: TextAlign.start,
        ),
        Divider(),
        Text('WavyAnimatedTextKit', style: titleTextStyle),
        SizedBox(
          height: 128,
          child: WavyAnimatedTextKit(
            textStyle: _kTextStyle,
            text: _kTexts,
            textAlign: TextAlign.center,
            isRepeatingAnimation: true,
          ),
        ),
        Divider(),
        Text('ScaleAnimatedTextKit', style: titleTextStyle),
        SizedBox(
          height: 64,
          width: 100,
          child: ScaleAnimatedTextKit(
            text: _kTexts,
            textStyle: _kTextStyle,
            textAlign: TextAlign.center,
            isRepeatingAnimation: true,
          ),
        ),
      ],
    );
  }
}
