import 'package:flutter/material.dart';
import 'package:live2d/drawer/customDrawer.dart';
import 'package:live2d/widgets/mmcafe.dart';


class chatroom extends StatefulWidget {
  chatroom({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _chatroomState createState() => _chatroomState();
}

class _chatroomState extends State<chatroom> {
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
      body: mmcafe(),
    );
  }
}
