import 'package:flutter/material.dart';
import 'package:live2d/drawer/customDrawer.dart';
import 'package:live2d/widgets/fabChatroom.dart';
import 'package:live2d/widgets/live3dresult.dart';


class live3d extends StatefulWidget {
  live3d({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _live3dState createState() => _live3dState();
}

class _live3dState extends State<live3d> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        
      ),
      //drawer: customDrawer(),
      body: live3dresult(),
      floatingActionButton: fabChatroom(),
    );
  }
}
