import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerExample extends StatefulWidget {
  const YoutubePlayerExample({super.key});

  @override
  State<YoutubePlayerExample> createState() => _YoutubePlayerExampleState();
}

class _YoutubePlayerExampleState extends State<YoutubePlayerExample> {
  final _txtController = TextEditingController();
  //! Use `YoutubePlayerController.fromVideoId` if just play a single video.
  final _ytController = YoutubePlayerController(
    params: const YoutubePlayerParams(
        showFullscreenButton: true, mute: false, showControls: true),
  );

  @override
  void initState() {
    super.initState();
    _txtController.text = 'https://www.youtube.com/watch?v=jfKfPfyJRdk';
  }

  String? _getVideoId() {
    if (_txtController.text.startsWith('https://youtu.be/')) {
      return _txtController.text.substring('https://youtu.be/'.length);
    } else if (_txtController.text
        .startsWith('https://www.youtube.com/watch?v=')) {
      return _txtController.text
          .substring('https://www.youtube.com/watch?v='.length);
    }
    return null;
  }

  Future<void> _play() async {
    final videoId = _getVideoId();
    if (videoId == null) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
                'Failed to extract video Id from "${_txtController.text}"!\n'
                'Please make sure it is in either "https://youtu.be/\$id" or "https://www.youtube.com/watch?v=\$id" format!'),
          ),
        );
      return;
    }
    //? loadVideoByUrl doesn't work?
    // await _ytController.loadVideoByUrl(mediaContentUrl: _txtController.text);
    await _ytController.loadVideoById(videoId: videoId);
  }

  @override
  Widget build(BuildContext context) {
    // We can add the player along with other widgets with the YoutubePlayerScaffold
    return YoutubePlayerScaffold(
      builder: (ctx, player) => SingleChildScrollView(
        child: Column(
          children: [
            Text('YT player iframe'),
            TextField(controller: _txtController),
            ElevatedButton(onPressed: _play, child: Text('play')),
            player,
          ],
        ),
      ),
      controller: _ytController,
    );
  }
}
