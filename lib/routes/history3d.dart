import 'package:flutter/material.dart';
import 'package:live2d/drawer/customDrawer.dart';
import 'package:live2d/widgets/fabChatroom.dart';


class history3d extends StatefulWidget {
  history3d({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _history3dState createState() => _history3dState();
}

class _history3dState extends State<history3d> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //drawer: customDrawer(),
      body: Center(
          child: Center(
            child: Text("Coming soon..."),
          )
      ),
      floatingActionButton: fabChatroom(),
    );
  }
}
