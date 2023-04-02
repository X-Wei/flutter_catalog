import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../my_app_settings.dart';

class ChatGptExample extends ConsumerStatefulWidget {
  const ChatGptExample({super.key});

  @override
  ConsumerState<ChatGptExample> createState() => _ChatGptExampleState();
}

class _ChatGptExampleState extends ConsumerState<ChatGptExample> {
  static const _apiKey =
      String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
  late final OpenAI _openAiClient = OpenAI.instance.build(
    token: _apiKey,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 20)),
    isLog: true,
  );
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool _pendingResponse = false;
  //! List of (message:string, isMe:bool) pairs to represent the conversation.
  final _messages = <Tuple2<String, bool>>[];

  Future<String> _askChatGpt(String prompt) async {
    final request = ChatCompleteText(
      messages: [
        Map.of({"role": "user", "content": prompt})
      ],
      model: kChatGptTurboModel,
      maxToken: 500,
    );
    try {
      final response = await _openAiClient.onChatCompletion(request: request);
      if (response == null) {
        return 'Error: response is empty!';
      }
      return response.choices[0].message.content;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, i) =>
                  _buildMessageTile(_messages[i].item1, _messages[i].item2),
              itemCount: _messages.length,
            ),
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
        _buildTextComposer(),
        Divider(height: 1.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                '${ref.watch(mySettingsProvider).chatGptTurns} free turns left'),
            TextButton.icon(
              label: Text('More quota'),
              icon: Icon(Icons.emoji_events),
              onPressed: () => Navigator.of(context)
                  .pushNamed('/monetization_rewarded_ad_ex'),
            ),
          ],
        )
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

  Widget _buildMessageTile(String message, bool isMe) {
    final avatar = isMe
        ? CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Text('Me'),
          )
        : CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(CommunityMaterialIcons.robot),
          );

    final msgBubble = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.grey[300] : Colors.blue[100],
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isMe ? Colors.black : Colors.black87,
          fontSize: 16.0,
        ),
        textAlign: isMe ? TextAlign.right : TextAlign.left,
      ),
    );
    return ListTile(
      leading: isMe ? null : avatar,
      trailing: isMe ? avatar : null,
      title: msgBubble,
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                enabled: !_pendingResponse,
                controller: _textController,
                maxLines: null,
                maxLength: 200,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
