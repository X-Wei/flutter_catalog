import 'package:flutter/material.dart';
import '../my_route.dart';

class HeroExample extends MyRoute {
  const HeroExample([String sourceFile = 'lib/routes/animation_hero_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Hero';

  @override
  get description => 'Hero animation between routes.';

  @override
  get links => {
        'cookbook':
            'https://flutter.io/docs/development/ui/animations/hero-animations',
        'Youtube video': 'https://www.youtube.com/watch?v=Be9UH1kXFDw',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          ListTile(
            leading: GestureDetector(
              child: Hero(
                tag: 'my-hero-animation-tag',
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('res/images/material_design_3.png'),
                ),
              ),
              onTap: () => _showSecondPage(context),
            ),
            title: Text('Tap on the photo to view the animation transition.'),
          ),
        ],
      ),
    );
  }

  void _showSecondPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
              body: Center(
                child: Hero(
                  tag: 'my-hero-animation-tag',
                  child: Image.asset('res/images/material_design_3.png'),
                ),
              ),
            ),
      ),
    );
  }
}
