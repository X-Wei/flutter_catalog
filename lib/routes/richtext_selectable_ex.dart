import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:selectable/selectable.dart';

class SelectableExample extends StatelessWidget {
  const SelectableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Selectable(
        popupMenuItems: [
          // !Predefined popup menu items
          SelectableMenuItem(type: SelectableMenuItemType.copy),
          SelectableMenuItem(type: SelectableMenuItemType.define),
          // ! Custom popup menu items
          SelectableMenuItem(
            title: 'Foo :)',
            isEnabled: (controller) => controller!.isTextSelected,
            handler: (controller) {
              showDialog<void>(
                context: context,
                builder: (builder) {
                  return AlertDialog(
                    title: const Text('Custom menu!'),
                    content: Text('This is a custom action\n'
                        'Selected text = `${controller!.getSelection()!.text!}`'),
                  );
                },
              );
              return true;
            },
          ),
        ],
        child: MarkdownBody(
          //! Use MarkdownBody rather than Markdown, to let SingleChildScrollView handle scrolling
          data: _markdownSrc,
          selectable: false, //! Disable Markdown widget's own select function.
        ),
      ),
    );
  }
}

const String _markdownSrc = '''
# Selectable
A Flutter widget that enables text selection over all the text widgets it contains.

Try it out at: https://ronjb.github.io/selectable

And use Selectable where appropriate. For example:

```
Scaffold(
  body: SingleChildScrollView(
    child: Selectable(
      child: Column(
        children: [
          Text('... a lot of text ...'),
          // ... more widgets of any type that might contain text ...
        ],
      )
    )
  )
)
```

Selectable by default supports long-pressing on a word to select it, then using the selection handles to adjust the selection. To also enable double-tapping on a word to select it, pass in `selectWordOnDoubleTap: true` like this:

```
Selectable(
  selectWordOnDoubleTap: true,
  child: child,
)
```

## Note on scrollable widget
If a scrollable widget (such as `SingleChildScrollView`, `ListView`, `CustomScrollView`, etc.) is used to wrap the text widgets you want to enable selection for, the Selectable widget must be a descendant of the scrollable widget, and an ancestor of the text widgets.

## Links
Selectable provides a default popup selection menu with the menu items Copy, Define, and WebSearch, but it can easily be customized. See source code as an example.

## Add an Issue for Questions or Problems 
Look at the code in the example app included with this package for more usage details and example code, and feel free to add an issue to ask questions or report problems you find while using this package: https://github.com/ronjb/selectable/issues

''';
