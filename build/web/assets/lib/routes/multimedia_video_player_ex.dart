import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerExample extends StatefulWidget {
  const VideoPlayerExample({Key key}) : super(key: key);

  @override
  _VideoPlayerExampleState createState() => _VideoPlayerExampleState();
}

class _VideoPlayerExampleState extends State<VideoPlayerExample> {
  VideoPlayerController _videoController;
  VideoPlayerController _audioController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      // **When the controllers change, call setState() to rebuild widget.**
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();
    _audioController = VideoPlayerController.network(
        'https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(4),
      children: <Widget>[
        const ListTile(title: Text('Play online video:')),
        Center(
          child: _videoController.value.initialized
              ? _buildVideoPlayerUI()
              : const CircularProgressIndicator(),
        ),
        const Divider(),
        const ListTile(title: Text('Play online audio:')),
        Center(
          child: _audioController.value.initialized
              ? _buildAudioPlayerUI()
              : const LinearProgressIndicator(),
        ),
        const Divider(),
        const ListTile(
            title: Text('(Also possible to play media from local file or '
                'from assets, or display subtitles. '
                'Cf. the plugin documentation.)')),
      ],
    );
  }

  Widget _buildVideoPlayerUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        ),
        Text(
            '${_videoController.value.position} / ${_videoController.value.duration}'),
        VideoProgressIndicator(_videoController, allowScrubbing: true),
        ElevatedButton.icon(
          onPressed: () => _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play(),
          icon: Icon(_videoController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow),
          label: Text(_videoController.value.isPlaying ? 'Pause' : 'Play'),
        ),
      ],
    );
  }

  Widget _buildAudioPlayerUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        VideoProgressIndicator(_audioController, allowScrubbing: true),
        Text(
            '${_audioController.value.position} / ${_audioController.value.duration}'),
        ElevatedButton.icon(
          onPressed: () => _audioController.value.isPlaying
              ? _audioController.pause()
              : _audioController.play(),
          icon: Icon(_audioController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow),
          label: Text(_audioController.value.isPlaying ? 'Pause' : 'Play'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
