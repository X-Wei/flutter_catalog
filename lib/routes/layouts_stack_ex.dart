import 'package:flutter/material.dart';
import '../my_route.dart';

class StackExample extends MyRoute {
  const StackExample([String sourceFile = 'lib/routes/layouts_stack_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Stack';

  @override
  get description => 'Putting widget on top of another.';

  @override
  get links => {
        "Youtube video": "https://www.youtube.com/watch?v=RJEnTRBxaSg&t=1072s",
        'Doc': 'https://docs.flutter.io/flutter/widgets/Stack-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _StackPage();
  }
}

// Inspired by bizz84's layout demo:
// https://github.com/bizz84/layout-demo-flutter
class _StackPage extends StatefulWidget {
  @override
  _StackPageState createState() => new _StackPageState();
}

class _StackPageState extends State<_StackPage> {
  AlignmentDirectional _alignmentDirectional = AlignmentDirectional.topStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: _alignmentDirectional,
          children: <Widget>[
            Container(width: 300.0, height: 300.0, color: Colors.red),
            Container(width: 200.0, height: 200.0, color: Colors.green),
            Container(width: 100.0, height: 100.0, color: Colors.blue),
          ],
        ),
      ),
      bottomNavigationBar: _getBottomBar(),
    );
  }

  Widget _getBottomBar() {
    const kAlignmentDirectionalVals = <String, AlignmentDirectional>{
      'topStart': AlignmentDirectional.topStart,
      'topCenter': AlignmentDirectional.topCenter,
      'topEnd': AlignmentDirectional.topEnd,
      'centerStart': AlignmentDirectional.centerStart,
      'center': AlignmentDirectional.center,
      'centerEnd': AlignmentDirectional.centerEnd,
      'bottomStart': AlignmentDirectional.bottomStart,
      'bottomCenter': AlignmentDirectional.bottomCenter,
      'bottomEn': AlignmentDirectional.bottomEnd
    };
    return Material(
      color: Theme.of(context).primaryColorLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('alignmentDirectional:'),
            trailing: DropdownButton<AlignmentDirectional>(
              value: _alignmentDirectional,
              onChanged: (AlignmentDirectional newVal) {
                if (newVal != null) {
                  setState(() => this._alignmentDirectional = newVal);
                }
              },
              items: kAlignmentDirectionalVals
                  .map(
                    (String name, AlignmentDirectional val) => MapEntry(
                          name,
                          DropdownMenuItem(value: val, child: Text(name)),
                        ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
