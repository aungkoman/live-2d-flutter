import 'package:flutter/material.dart';
import 'package:live2d/drawer/customDrawer.dart';
import 'package:live2d/widgets/fabChatroom.dart';


class aboutApp extends StatefulWidget {
  aboutApp({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _aboutAppState createState() => _aboutAppState();
}

class _aboutAppState extends State<aboutApp> {
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
            child: Text("2D/3D Live App"),
          )
      ),
      floatingActionButton: fabChatroom(),
    );
  }
}
