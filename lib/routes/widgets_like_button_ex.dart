import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonExample extends StatefulWidget {
  const LikeButtonExample({super.key});

  @override
  State<LikeButtonExample> createState() => _LikeButtonExampleState();
}

class _LikeButtonExampleState extends State<LikeButtonExample> {
  final GlobalKey<LikeButtonState> _key = GlobalKey<LikeButtonState>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Text('A bare like button:'),
        LikeButton(key: _key),
        Divider(),
        Text('Like button with count and count:'),
        LikeButton(
          likeBuilder: (isLiked) =>
              isLiked ? Icon(Icons.thumb_up) : Icon(Icons.thumb_up_outlined),
          likeCount: 100,
        ),
        Divider(),
        Text('Set isLiked=null to make it possible to like multiple times:'),
        LikeButton(
          likeBuilder: (isLiked) => Icon(Icons.thumb_up),
          likeCount: 996,
          isLiked: null,
          countBuilder: (likeCount, isLiked, text) {
            if (likeCount == 0) {
              return Text('like');
            } else {
              return Text(
                likeCount! >= 1000
                    ? '${(likeCount / 1000.0).toStringAsFixed(1)}k'
                    : text,
              );
            }
          },
        ),
        Divider(),
        ListTile(
          leading: FittedBox(child: LikeButton()),
          title: Text('Like button in list tile'),
          subtitle: Text('Must wrap it by a FittedBox'),
        ),
        Divider(),
        ListTile(
          title: Text('use global key to mutate like state elsewhere'),
          subtitle: Text(
              "click button below to toggle the first like button's state"),
        ),
        ElevatedButton(
          onPressed: () => _key.currentState?.onTap(),
          child: Text('toggle'),
        ),
      ],
    );
  }
}
