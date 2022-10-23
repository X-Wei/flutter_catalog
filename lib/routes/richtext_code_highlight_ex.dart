import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart' show themeMap;

class CodeHighlightExample extends StatefulWidget {
  const CodeHighlightExample({super.key});

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
  String _themeName = 'github';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          for (final entry in kLangToCodeSample.entries)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'language=${entry.key}',
                  // strutStyle: Theme.of(context).textTheme.headline2,
                ),
                HighlightView(
                  entry.value,
                  language: entry.key,
                  //! The themeMap contains all built-in themes in the package.
                  //`import 'package:flutter_highlight/theme_map.dart'`
                  theme: themeMap[_themeName] ?? {},
                ),
                Divider(),
              ],
            ),
        ],
      ),
      bottomNavigationBar: _buildThemeSelUI(),
    );
  }

  Widget _buildThemeSelUI() {
    return ListTile(
      title: const Text('DropDownButton with default:'),
      trailing: DropdownButton<String>(
        value: _themeName,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() => _themeName = newValue);
          }
        },
        items: [
          for (final name in themeMap.keys)
            DropdownMenuItem<String>(value: name, child: Text(name))
        ],
      ),
    );
  }
}
