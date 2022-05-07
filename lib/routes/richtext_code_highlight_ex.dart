import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodeHighlightExample extends StatefulWidget {
  const CodeHighlightExample({Key? key}) : super(key: key);

  @override
  State<CodeHighlightExample> createState() => _CodeHighlightExampleState();
}

const kLangToCodeSample = <String, String>{
  'dart': '''
main() {
  print("Hello, World!");
}''',
  'python': 'print("Hello World")',
  'cpp': '''
#include 
using namespace std;
int main () {
  cout << "Hello World!";
  return 0;
}''',
  'java': '''
class HelloWorldApp {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}''',
  'SQL': "SELECT Country FROM Customers WHERE Country <> 'USA'",
};

class _CodeHighlightExampleState extends State<CodeHighlightExample> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        for (final entry in kLangToCodeSample.entries)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'language=${entry.key}',
                // strutStyle: Theme.of(context).textTheme.headline2,
              ),
              HighlightView(
                entry.value,
                language: entry.key,
                theme: githubTheme,
              ),
              Divider(),
            ],
          ),
      ],
    );
  }
}
