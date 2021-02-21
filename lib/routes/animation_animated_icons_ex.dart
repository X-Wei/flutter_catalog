import 'package:flutter/material.dart';

const _kAllANimatedIcons = <String, AnimatedIconData>{
  'add_event': AnimatedIcons.add_event,
  'arrow_menu': AnimatedIcons.arrow_menu,
  'close_menu': AnimatedIcons.close_menu,
  'ellipsis_search': AnimatedIcons.ellipsis_search,
  'event_add': AnimatedIcons.event_add,
  'home_menu': AnimatedIcons.home_menu,
  'list_view': AnimatedIcons.list_view,
  'menu_arrow': AnimatedIcons.menu_arrow,
  'menu_close': AnimatedIcons.menu_close,
  'menu_home': AnimatedIcons.menu_home,
  'pause_play': AnimatedIcons.pause_play,
  'play_pause': AnimatedIcons.play_pause,
  'search_ellipsis': AnimatedIcons.search_ellipsis,
  'view_list': AnimatedIcons.view_list,
};

class AnimatedIconsExample extends StatelessWidget {
  const AnimatedIconsExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        const Text('Click on the icon to forward/reverse the animation.'),
        const Divider(),
        Wrap(
          spacing: 10,
          children: <Widget>[
            for (final kv in _kAllANimatedIcons.entries)
              Padding(
                padding: const EdgeInsets.all(8),
                child: _AnimIconDemoBox(name: kv.key, iconData: kv.value),
              )
          ],
        ),
      ],
    );
  }
}

// Adapted from Robert Brunhage's tutorial (https://youtu.be/ILATAD57gIc).
class _AnimIconDemoBox extends StatefulWidget {
  final AnimatedIconData iconData;
  final String name;

  const _AnimIconDemoBox(
      {Key key, @required this.iconData, @required this.name})
      : super(key: key);

  @override
  _AnimIconDemoBoxState createState() => _AnimIconDemoBoxState();
}

// ! Add SingleTickerProviderStateMixin to use animation controllers.
class _AnimIconDemoBoxState extends State<_AnimIconDemoBox>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            // ! Depending on the state, reverse or forward the animation.
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          },
          child: AnimatedIcon(
            // ! Set the animation progress to our animation controller
            progress: _animationController,
            icon: widget.iconData,
            size: 128,
          ),
        ),
        Text(widget.name),
      ],
    );
  }
}
