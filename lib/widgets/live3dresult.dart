import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:socket_io_client/socket_io_client.dart';
class live3dresult extends StatefulWidget {
  @override
  _live3dresultState createState() => _live3dresultState();
}

class _live3dresultState extends State<live3dresult> with TickerProviderStateMixin {

  String live3dDigit = "802";
  String live3dUpdateTime = "2020-10-20 23:59";

  Socket socket;
  Timer timer;

  Animation<Color> animation;
  AnimationController controller;

  TextStyle liveTextStyle(Animation animation) => TextStyle(
    fontSize: 102,
    color:  animation.value,
    fontStyle: FontStyle.italic,
  );
  final TextStyle setTableTitleStyle = TextStyle(
      fontSize: 16,
      color: Colors.white
  );
  final TextStyle setTableSubTitleStyle = TextStyle(
      fontSize: 14,
      color: Colors.grey
  );

  Widget liveResult(){
    return Container(
        padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
        child : AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return new Container(
                  child: Center(child: Text(live3dDigit,style: liveTextStyle(animation)),)
              );
            }
            )
    );
        //child: Center(child: Text(live3dDigit,style: liveTextStyle),));
  }

  Widget updatedTime(){
    return Center(child: Text('Updated on '+live3dUpdateTime),);
  }


  void _startTimer(){
    timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      Random rand = new Random();
      var digit = rand.nextInt(1000).toString();
      if(digit.length == 1 ) digit = "00"+digit;
      if(digit.length == 2 ) digit = "0"+digit;
      //print(timer.tick.toString());

      var dt = new DateTime.now();
      var dtStr = dt.toString();
      setState(() {
        live3dDigit = digit;
        live3dUpdateTime = "အင်တာနက် ချိတ်ဆက်နေပါသည်.....";
      });
      //print("digit "+digit.toString());
      //print(live3dDigit);
    });
  }

  void _receiveMessage(Map<String, dynamic> msg) {
    try{
      timer.cancel();
    }
    catch(exp){
      print("timer already cancled ");
      print(exp);
    }

    print("msg is ");
    print(msg);
    print(msg['live2d']);

    var dt = new DateTime.now();
    var dtStr = dt.toString();
    setState(() {
      live3dDigit = msg['live3d'].toString();
      live3dUpdateTime = dtStr;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    print("initState in live3dresult");
    _startTimer();
    super.initState();

    socket = io('https://shan-server.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.connect();

    socket.on('connect',(_){
      print("socket connected");
    });

    socket.on('connect_error',(_){
      print("socket connect error in live3dresult ");
      print(_.toString());
    });

    socket.on('data',(msg){
      print("socket on data event received");
      //print(msg);
      _receiveMessage(msg);
    });


    controller = AnimationController(
        duration: const Duration(milliseconds: 1000),vsync: this);

    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.ease);

    animation =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(curve);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        liveResult(),
        updatedTime(),
      ],
    );
  }
}
