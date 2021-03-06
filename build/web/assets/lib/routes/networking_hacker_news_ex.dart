import 'dart:convert';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class RestApiHackerNewsExample extends StatefulWidget {
  const RestApiHackerNewsExample({Key key}) : super(key: key);

  @override
  _RestApiHackerNewsExampleState createState() =>
      _RestApiHackerNewsExampleState();
}

class _RestApiHackerNewsExampleState extends State<RestApiHackerNewsExample> {
  List<int> _articleIds = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          const Text('This is a full example using the hacker news API, '
              'cf. https://github.com/HackerNews/API.\n'
              'We use a two-hop way to get articles: '
              'first we fetch the list of latest article Ids at https://hacker-news.firebaseio.com/v0/newstories.json, '
              'then for each id we get its content at https://hacker-news.firebaseio.com/v0/item/\$id.json'),
          const Divider(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: this._getLatestArticleIds,
              child: _articleIds.isEmpty
                  ? const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Text('(Pull to refresh)'),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                        itemCount: this._articleIds.length,
                        itemBuilder: (ctx, i) => FutureBuilder(
                          future: this._getArticleById(this._articleIds[i]),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                margin: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              );
                            }
                            final hnArticle = MyHackerNewsArticle.fromJson(json
                                .decode(snapshot.data) as Map<String, dynamic>);
                            return this._articleListTile(hnArticle);
                          },
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Fetches the list of latest article Ids from '/v0/newstories.json'.
  Future<void> _getLatestArticleIds() async {
    const url = 'https://hacker-news.firebaseio.com/v0/newstories.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<int> articleIds =
          List<int>.from(json.decode(response.body) as Iterable);
      setState(() => this._articleIds = articleIds);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching article Ids: $response'),
      ));
    }
  }

  // Gets the detail of an article by its id from '/v0/item/$id.json'.
  Future<String> _getArticleById(int id) async {
    final url = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final response = await http.get(url);
    assert(response.statusCode == 200);
    return response.body;
  }

  // Renders one article obj as a list tile.
  Widget _articleListTile(MyHackerNewsArticle article) {
    final formatter = DateFormat.yMd().add_jms();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(article.time * 1000);
    return ListTile(
      title: Text(article.title),
      subtitle: Text('${article.by} - '
          '${formatter.format(createdAt)}'),
      trailing: IconButton(
        icon: const Icon(Icons.open_in_new),
        onPressed: () async {
          if (await url_launcher.canLaunch(article.url)) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => WebviewScaffold(
                  initialChild:
                      const Center(child: CircularProgressIndicator()),
                  url: article.url,
                  appBar: AppBar(title: Text(article.title)),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

/// This data class is generated from https://javiercbk.github.io/json_to_dart/.
class MyHackerNewsArticle {
  String by;
  int descendants;
  int id;
  int score;
  int time;
  String title;
  String type;
  String url;

  MyHackerNewsArticle(
      {this.by,
      this.descendants,
      this.id,
      this.score,
      this.time,
      this.title,
      this.type,
      this.url});

  MyHackerNewsArticle.fromJson(Map<String, dynamic> json) {
    by = json['by'] as String;
    descendants = json['descendants'] as int;
    id = json['id'] as int;
    score = json['score'] as int;
    time = json['time'] as int;
    title = json['title'] as String;
    type = json['type'] as String;
    url = json['url'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['by'] = this.by;
    data['descendants'] = this.descendants;
    data['id'] = this.id;
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
