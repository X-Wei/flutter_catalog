import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

class SuperEditorExample extends StatefulWidget {
  const SuperEditorExample({super.key});

  @override
  State<SuperEditorExample> createState() => _SuperEditorExampleState();
}

// Adapted from https://github.com/superlistapp/super_editor/blob/main/super_editor/example/lib/demos/example_editor/example_editor.dart
class _SuperEditorExampleState extends State<SuperEditorExample> {
  final GlobalKey _docLayoutKey = GlobalKey();
  final _scrollController = ScrollController();
  final _editorFocusNode = FocusNode();

  late Document _doc;
  late DocumentEditor _editor;
  late DocumentComposer _composer;
  late CommonEditorOperations _ops;
  void _cut() => _ops.cut();
  void _copy() => _ops.copy();
  void _paste() => _ops.paste();
  void _selectAll() => _ops.selectAll();

  @override
  void initState() {
    super.initState();
    //! Note: we can serialized to/from markdown! See https://github.com/superlistapp/super_editor/tree/main/super_editor_markdown.
    _doc = MutableDocument(
      nodes: [
        ImageNode(
            id: DocumentEditor.createNodeId(),
            imageUrl:
                'https://user-images.githubusercontent.com/7259036/170845431-e83699df-5c6c-4e9c-90fc-c12277cc2f48.png'),
        ParagraphNode(
          id: DocumentEditor.createNodeId(),
          text: AttributedText(text: 'SuperEditor'),
          metadata: {'blockType': header1Attribution},
        ),
      ],
    );
    _editor = DocumentEditor(document: _doc as MutableDocument);
    _composer = DocumentComposer();
    _ops = CommonEditorOperations(
      editor: _editor,
      composer: _composer,
      documentLayoutResolver: () =>
          // ignore: cast_nullable_to_non_nullable
          _docLayoutKey.currentState as DocumentLayout,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _editorFocusNode.dispose();
    _composer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SuperEditor(
              editor: _editor,
              composer: _composer,
              documentLayoutKey: _docLayoutKey,
              scrollController: _scrollController,
              focusNode: _editorFocusNode,
              inputSource: DocumentInputSource.ime,
              keyboardActions: defaultImeKeyboardActions,
              androidToolbarBuilder: (_) => AndroidTextEditingFloatingToolbar(
                onCutPressed: _cut,
                onCopyPressed: _copy,
                onPastePressed: _paste,
                onSelectAllPressed: _selectAll,
              ),
              iOSToolbarBuilder: (_) => IOSTextEditingFloatingToolbar(
                onCutPressed: _cut,
                onCopyPressed: _copy,
                onPastePressed: _paste,
              ),
            ),
          ),
          _buildMountedToolbar(),
        ],
      ),
    );
  }

  Widget _buildMountedToolbar() {
    return SizedBox(
      height: 32,
      child: MultiListenableBuilder(
        listenables: <Listenable>{_doc, _composer.selectionNotifier},
        builder: (_) => _composer.selection == null
            ? const SizedBox()
            : KeyboardEditingToolbar(
                document: _doc, composer: _composer, commonOps: _ops),
      ),
    );
  }
}
