import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DioDownloadExample extends StatefulWidget {
  const DioDownloadExample(
      {super.key,
      this.downloadUrl =
          'https://github.com/X-Wei/flutter_catalog/archive/refs/heads/master.zip'});
  final String downloadUrl;
  @override
  _DioDownloadExampleState createState() => _DioDownloadExampleState();
}

class _DioDownloadExampleState extends State<DioDownloadExample> {
  final Dio _dio = Dio();
  bool _isDownloading = false;
  bool _downloadSuccess = false;
  double _progress = 0.0;
  late String _localFilename;
  String? _localFilepath;
  late String _downloadUrl;

  @override
  void initState() {
    super.initState();
    _downloadUrl = widget.downloadUrl;
    _localFilename = path.basename(_downloadUrl);
  }

  Future<void> _dioDownload() async {
    final filePath = path.join(
        (await getApplicationDocumentsDirectory()).path, _localFilename);
    setState(() => _isDownloading = true);
    Fluttertoast.showToast(msg: 'Download started');
    try {
      await _dio.download(
        _downloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          setState(() => _progress = received / total);
        },
      );
      setState(() {
        _localFilepath = filePath;
        _isDownloading = false;
        _downloadSuccess = true;
      });
    } catch (e) {
      debugPrint('Error: $e');
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(title: Text('Error'), content: Text('$e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            initialValue: _downloadUrl,
            decoration: InputDecoration(labelText: 'Download URL'),
            onChanged: (value) => this._downloadUrl = value,
          ),
          TextFormField(
            initialValue: _localFilename,
            decoration: InputDecoration(labelText: 'Local Filename'),
            onChanged: (value) => this._localFilename = value,
          ),
          ElevatedButton(
            onPressed: _isDownloading ? null : _dioDownload,
            child: Text('Start Download'),
          ),
          SizedBox(height: 20),
          if (_isDownloading)
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          if (_downloadSuccess)
            SelectableText('file downloaded at `$_localFilepath`'),
        ],
      ),
    );
  }
}
