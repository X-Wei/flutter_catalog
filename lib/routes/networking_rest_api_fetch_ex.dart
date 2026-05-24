import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApiFetchExample extends StatefulWidget {
  const RestApiFetchExample({super.key});

  @override
  _RestApiFetchExampleState createState() => _RestApiFetchExampleState();
}

class _RestApiFetchExampleState extends State<RestApiFetchExample> {
  late TextEditingController _urlController;
  late TextEditingController _apiTokenController;
  final _responseBody = ValueNotifier<String>('<empty>');
  final _error = ValueNotifier<String>('<none>');
  final _pending = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    this._apiTokenController = TextEditingController();
    this._urlController = TextEditingController()
      ..text = 'https://jsonplaceholder.typicode.com/posts/1';
  }

  @override
  void dispose() {
    _urlController.dispose();
    _apiTokenController.dispose();
    _responseBody.dispose();
    _error.dispose();
    _pending.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        TextField(
          controller: this._urlController,
          decoration: const InputDecoration(
            labelText: 'URL to GET',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: this._apiTokenController,
          decoration: const InputDecoration(
            labelText: 'Optional api token',
            border: OutlineInputBorder(),
          ),
        ),
        OverflowBar(
          children: <Widget>[
            ValueListenableBuilder<bool>(
              valueListenable: _pending,
              builder: (context, pending, _) => ElevatedButton(
                onPressed: pending
                    ? null
                    : () => this._httpGet(
                        _urlController.text,
                        _apiTokenController.text,
                      ),
                child: const Text('Get'),
              ),
            ),
            ElevatedButton(onPressed: this._reset, child: const Text('Reset')),
          ],
        ),
        ValueListenableBuilder<String>(
          valueListenable: _responseBody,
          builder: (context, responseBody, _) => Text(
            'Response body=$responseBody',
          ),
        ),
        const Divider(),
        ValueListenableBuilder<String>(
          valueListenable: _error,
          builder: (context, error, _) => Text('Error=$error'),
        ),
      ],
    );
  }

  void _reset({bool resetControllers = true}) {
    if (resetControllers) {
      this._urlController.text = 'https://jsonplaceholder.typicode.com/posts/1';
    }
    _responseBody.value = '<empty>';
    _error.value = '<none>';
    _pending.value = false;
  }

  // Using the http package we can easily GET data from REST APIs.
  Future<void> _httpGet(String url, String apiToken) async {
    _reset();
    _pending.value = true;
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: apiToken},
      );
      // Usually we will add code to convert the response body into our data
      // class, e.g. using https://javiercbk.github.io/json_to_dart/.
      // **Tip**: use compute() function (from flutter/foundation.dart) to run
      // heavy json parsing work in a background isolate.
      final parsed = await compute(jsonDecode, response.body);
      print('parsed json object=$parsed');
      _responseBody.value = response.body;
    } catch (e) {
      _error.value = e.toString();
    }
    _pending.value = false;
  }
}
