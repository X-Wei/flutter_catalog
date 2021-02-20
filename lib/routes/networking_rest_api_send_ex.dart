import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApiSendExample extends StatefulWidget {
  const RestApiSendExample({Key key}) : super(key: key);

  @override
  _RestApiSendExampleState createState() => _RestApiSendExampleState();
}

class _RestApiSendExampleState extends State<RestApiSendExample> {
  TextEditingController _titleController;
  TextEditingController _contentController;
  TextEditingController _userIdController;
  String _responseBody = '<empty>';
  String _error = '<none>';
  bool _pending = false;

  @override
  void initState() {
    super.initState();
    this._contentController = TextEditingController();
    this._titleController = TextEditingController();
    this._userIdController = TextEditingController();
    _reset();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        const Text('''
In this example we will POST to the jsonplaceholder API.

From https://jsonplaceholder.typicode.com/guide.html we see that the API expects title, body and userId in the request body.'''),
        const Divider(),
        TextField(
          controller: this._titleController,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: this._contentController,
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'Content',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: this._userIdController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'UserId',
            border: OutlineInputBorder(),
          ),
        ),
        ButtonBar(
          children: <Widget>[
            ElevatedButton(
              onPressed: _pending
                  ? null
                  : () => this._httpPost(
                        _titleController.text,
                        _contentController.text,
                        _userIdController.text,
                      ),
              child: const Text('Post'),
            ),
            ElevatedButton(
              onPressed: this._reset,
              child: const Text('Reset'),
            ),
          ],
        ),
        Text('Response body=$_responseBody'),
        const Divider(),
        Text('Error=$_error'),
      ],
    );
  }

  void _reset({bool resetControllers = true}) {
    setState(() {
      if (resetControllers) {
        this._titleController.text = 'Lorem Ipsum Title';
        this._contentController.text =
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas congue quisque egestas diam in arcu. Quis imperdiet massa tincidunt nunc pulvinar. ''';
        this._userIdController.text = '1';
      }
      this._responseBody = '<empty>';
      this._error = '<none>';
      this._pending = false;
    });
  }

  Future<void> _httpPost(String title, String body, String userId) async {
    _reset(resetControllers: false);
    setState(() => this._pending = true);
    try {
      final http.Response response = await http.post(
        'https://jsonplaceholder.typicode.com/posts',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'body': body,
          'userId': userId,
        }),
      );
      // If the server did return a 201 CREATED response.
      if (response.statusCode == 201) {
        setState(() => this._responseBody = response.body);
      } else {
        setState(() => this._error = 'Failed to add a post: $response');
      }
    } catch (e) {
      setState(() => this._error = 'Failed to add a post: $e');
    }
    setState(() => this._pending = false);
  }
}
