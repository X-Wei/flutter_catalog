import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groq/groq.dart';
import 'package:tuple/tuple.dart';

import '../my_app_settings.dart';
import 'widgets_dropdown_button_ex.dart';

class GroqExample extends ConsumerStatefulWidget {
  const GroqExample({super.key});

  @override
  ConsumerState<GroqExample> createState() => _ChatGptExampleState();
}

class _ChatGptExampleState extends ConsumerState<GroqExample> {
  static const _apiKey =
      String.fromEnvironment('GROQ_API_KEY', defaultValue: '');
  final groq = Groq(apiKey: _apiKey, model: GroqModel.llama3_8b_8192);
  var _groqModel = GroqModel.llama3_8b_8192;

  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool _pendingResponse = false;
  //! List of (message:string, isMe:bool) pairs to represent the conversation.
  final _messages = <Tuple2<String, bool>>[];

  @override
  void initState() {
    super.initState();
    groq.startChat();
  }

  void _changeModel(GroqModel m) {
    _groqModel = m;
    _messages.clear();
    groq.clearChat();
    groq.startChat();
    setState(() {});
  }

  Future<String> _askChatGpt(String prompt) async {
    try {
      final response = await groq.sendMessage(prompt);
      return response.choices.firstOrNull?.message.content ?? "<error>";
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
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            reverse: true,
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
        MyValuePickerTile<GroqModel>(
            val: _groqModel,
            values: GroqModel.values,
            title: 'Select a model: ',
            onChanged: _changeModel),
        Divider(),
        MyTextComposer(
            handleSubmitted: _handleSubmitted,
            pendingResponse: _pendingResponse),
        Divider(height: 1.0),
        MyAiChatQuotaBar(),
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

/// A simple chat text composer UI.
/// ![](../../screenshots/my-chat-text-composer.png)
class MyTextComposer extends StatefulWidget {
  const MyTextComposer(
      {super.key,
      required this.handleSubmitted,
      required this.pendingResponse});

  @override
  _MyTextComposerState createState() => _MyTextComposerState();
  final Future<void> Function(String) handleSubmitted;
  final bool pendingResponse;
}

class _MyTextComposerState extends State<MyTextComposer> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _handleSubmitted(String text) async {
    await widget.handleSubmitted(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              enabled: !widget.pendingResponse,
              controller: _controller,
              maxLines: null,
              maxLength: 200,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
              textInputAction: TextInputAction.send, //! Allows "enter" to send.
              onSubmitted: _handleSubmitted,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_controller.text),
            ),
          ),
        ],
      ),
    );
  }
}

/// A bar showing how many turns left, and a btn to get more quota.
/// ![](../../screenshots/chatai-quota-bar.png)
class MyAiChatQuotaBar extends ConsumerWidget {
  const MyAiChatQuotaBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${ref.watch(mySettingsProvider).chatGptTurns} free turns left'),
        TextButton.icon(
          label: Text('More quota'),
          icon: Icon(Icons.emoji_events),
          onPressed: () =>
              Navigator.of(context).pushNamed('/monetization_rewarded_ad_ex'),
        ),
      ],
    );
  }
}

class MyMessageBubbleTile extends StatelessWidget {
  const MyMessageBubbleTile({
    super.key,
    required this.message,
    required this.isMe,
  });

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final avatar = isMe
        ? CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Text('Me'),
          )
        : CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(CommunityMaterialIcons.robot),
          );

    final msgBubble = Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: isMe
              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
              : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Colors.blue[100],
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
          ),
          child: MarkdownBody(data: message, selectable: true),
        ));
    return ListTile(
      leading: isMe ? null : avatar,
      trailing: isMe ? avatar : null,
      title: msgBubble,
    );
  }
}
