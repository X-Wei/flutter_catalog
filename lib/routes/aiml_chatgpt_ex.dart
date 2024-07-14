import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../my_app_settings.dart';
import 'aiml_groq_ex.dart';

class ChatGptExample extends ConsumerStatefulWidget {
  const ChatGptExample({super.key});

  @override
  ConsumerState<ChatGptExample> createState() => _ChatGptExampleState();
}

class _ChatGptExampleState extends ConsumerState<ChatGptExample> {
  ///! NOTE: be sure to top-up credits, otherwise will get error 429...
  static const _apiKey =
      String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
  late final OpenAI _openAiClient = OpenAI.instance.build(
    token: _apiKey,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 20)),
    enableLog: true,
  );
  final _textController = TextEditingController();
  bool _pendingResponse = false;
  //! List of (message:string, isMe:bool) pairs to represent the conversation.
  final _messages = <Tuple2<String, bool>>[];

  Future<String> _askChatGpt(String prompt) async {
    final request = ChatCompleteText(
      messages: [
        //! Add previous messages to the context.
        ...[
          for (final m in _messages)
            Map.of({'role': m.item2 ? 'user' : 'assistant', 'content': m.item1})
        ],
        Map.of({'role': 'user', 'content': prompt})
      ],
      model: GptTurboChatModel(),
      maxToken: 500,
    );
    try {
      final response = await _openAiClient.onChatCompletion(request: request);
      if (response == null) {
        return 'Error: response is empty!';
      }
      return response.choices[0].message?.content ?? "<error>";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            reverse: true,
            //! MyMessageBubbleTile is defined in aiml_groq_ex.dart.
            itemBuilder: (_, i) => MyMessageBubbleTile(
                message: _messages[i].item1, isMe: _messages[i].item2),
            itemCount: _messages.length,
          ),
        ),
        if (_pendingResponse)
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(CommunityMaterialIcons.robot)),
            title: LinearProgressIndicator(),
          ),
        Divider(height: 1.0),
        //! TODO: add a MyValuePickerTile for different models.
        //! MyTextComposer is defined in aiml_groq_ex.dart.
        MyTextComposer(
            handleSubmitted: _handleSubmitted,
            pendingResponse: _pendingResponse),
        Divider(height: 1.0),
        MyAiChatQuotaBar(),
        // TODO: add chatGPT model picker.
      ],
    );
  }

  Future<void> _handleSubmitted(String text) async {
    if (ref.read(mySettingsProvider).chatGptTurns <= 0) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Quota used up'),
          content: const Text(
              'You can watch ads to gain more quota: watch 1 ad to get 10 coins, which is worth 50 turns.\n\n'
              'Just click on the "More quota" button in the bottom-right.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            )
          ],
        ),
      );
      return;
    }
    _textController.clear();
    setState(() {
      _messages.insert(0, Tuple2(text, true));
      _pendingResponse = true;
    });
    final resp = await _askChatGpt(text);
    setState(() {
      _pendingResponse = false;
      _messages.insert(0, Tuple2(resp, false));
      ref.read(mySettingsProvider).chatGptTurns--;
    });
  }
}
