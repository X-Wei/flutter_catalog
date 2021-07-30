import 'package:animated_radial_menu/animated_radial_menu.dart';
import 'package:flutter/material.dart';

class RadialMenuExample extends StatelessWidget {
  const RadialMenuExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text("Animated Radial Menu Example"),
        centerTitle: true,
      ),
      body: RadialMenu(children: [
        RadialButton(
            icon: Icon(Icons.ac_unit),
            buttonColor: Colors.teal,
            onPress: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TargetScreen()))),
        RadialButton(
            icon: Icon(Icons.camera_alt),
            buttonColor: Colors.green,
            onPress: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TargetScreen()))),
        RadialButton(
            icon: Icon(Icons.map),
            buttonColor: Colors.orange,
            onPress: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TargetScreen()))),
        RadialButton(
            icon: Icon(Icons.access_alarm),
            buttonColor: Colors.indigo,
            onPress: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TargetScreen()))),
        RadialButton(
            icon: Icon(Icons.watch),
            buttonColor: Colors.pink,
            onPress: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TargetScreen()))),
      ]),
    );
  }
}

class TargetScreen extends StatelessWidget {
  const TargetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Target Screen")),
    );
  }
}
