import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart'
    show QuillController, QuillEditor, QuillToolbar;

class QuillExample extends StatefulWidget {
  const QuillExample({super.key});

  @override
  State<QuillExample> createState() => _QuillExampleState();
}

class _QuillExampleState extends State<QuillExample> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    //! Or: load previously-stored content by:
    // var myJSON = jsonDecode(incomingJSONText);
    // _controller = QuillController(
    //           document: Document.fromJson(myJSON),
    //           selection: TextSelection.collapsed(offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: QuillToolbar.basic(controller: _controller),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: QuillEditor.basic(
          controller: _controller,
          readOnly: false,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final jsonStr = jsonEncode(_controller.document.toDelta().toJson());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Serialized content json:\n```\n$jsonStr\n```')),
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
