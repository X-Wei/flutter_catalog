import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomSheetExample extends StatefulWidget {
  const BottomSheetExample({Key key}) : super(key: key);

  @override
  _BottomSheetExampleState createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  // GlobalKey is needed to show bottom sheet.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => this
                  ._scaffoldKey
                  .currentState
                  .showBottomSheet((ctx) => _buildBottomSheet(ctx)),
              child: const Text('show bottom sheet'),
            ),
            ElevatedButton(
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (ctx) => _buildBottomSheet(ctx)),
              child: const Text('show modal bottom sheet'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Fluttertoast.showToast(msg: 'Dummy floating action button'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView(
        children: <Widget>[
          const ListTile(title: Text('Bottom sheet')),
          const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.attach_money),
              labelText: 'Enter an integer',
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save and close'),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
