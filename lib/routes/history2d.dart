import 'package:flutter/material.dart';
import 'package:live2d/drawer/customDrawer.dart';
import 'package:live2d/widgets/fabChatroom.dart';


class history2d extends StatefulWidget {
  history2d({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _history2dState createState() => _history2dState();
}

class _history2dState extends State<history2d> {
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
