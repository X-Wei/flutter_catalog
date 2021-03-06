import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class FileReadWriteExample extends StatefulWidget {
  const FileReadWriteExample({Key key}) : super(key: key);

  @override
  _FileReadWriteExampleState createState() => _FileReadWriteExampleState();
}

class _FileReadWriteExampleState extends State<FileReadWriteExample> {
  static const String kLocalFileName = 'file_rw_demo_localfile.txt';
  final TextEditingController _textController = TextEditingController();
  String _localFileContent = '';
  String _localFilePath = kLocalFileName;

  @override
  void initState() {
    super.initState();
    this._loadTextFromLocalFile();
    this
        ._getLocalFile()
        .then((file) => setState(() => this._localFilePath = file.path));
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode textFieldFocusNode = FocusNode();
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        const Text('Write to local file:'),
        TextField(
          focusNode: textFieldFocusNode,
          controller: _textController,
          maxLines: null,
        ),
        ButtonBar(
          children: <Widget>[
            MaterialButton(
              onPressed: () async {
                this._loadTextFromLocalFile();
                this._textController.text = this._localFileContent;
                _showSnackBar('String successfully loaded from local file.');
                // Focus on text field (bring keyboard up).
                FocusScope.of(context).requestFocus(textFieldFocusNode);
              },
              child: const Text('Load'),
            ),
            MaterialButton(
              onPressed: () async {
                await this._writeTextToLocalFile(this._textController.text);
                this._textController.clear();
                _showSnackBar('String successfully written to local file".');
                await this._loadTextFromLocalFile();
              },
              child: const Text('Save'),
            ),
          ],
        ),
        const Divider(height: 20.0),
        const Text('Local file path:'),
        Text(this._localFilePath, style: Theme.of(context).textTheme.caption),
        const Divider(height: 20.0),
        const Text('Local file content:'),
        Text(this._localFileContent,
            style: Theme.of(context).textTheme.caption),
      ],
    );
  }

  Future<File> _getLocalFile() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    return File('${directory.path}/$kLocalFileName');
  }

  Future<File> _writeTextToLocalFile(String text) async {
    final file = await _getLocalFile();
    return file.writeAsString(text);
  }

  // Loads local file into this._localFileContent.
  Future<void> _loadTextFromLocalFile() async {
    String content;
    try {
      final file = await _getLocalFile();
      content = await file.readAsString();
    } catch (e) {
      content = 'Error loading local file: $e';
    }
    setState(() {
      this._localFileContent = content;
    });
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(this.context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
