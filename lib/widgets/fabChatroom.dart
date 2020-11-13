import 'package:flutter/material.dart';

class fabChatroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.pushNamed(context, '/chatroom');
      },
      backgroundColor: Colors.red,
      tooltip: 'Chat Room',
      child: Icon(Icons.message),
    );
  }
}
