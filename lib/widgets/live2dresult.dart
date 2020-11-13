import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart';

class live2dresult extends StatefulWidget {
  @override
  _live2dresultState createState() => _live2dresultState();
}

class _live2dresultState extends State<live2dresult> with TickerProviderStateMixin{

  Socket socket;

  var live3dDigit = "802";
  var live2dDigit = "02";
  var live2dUpdateTime = "2020-10-20 23:59";
  var set12pm = "1,234";
  var val12pm = "4,322";
  var digit12pm = "23";
  var set4pm = "2,342";
  var val4pm = "5,456";
  var digit4pm = "33";
  var mod9am = "34";
  var internet9am = "54";
  var mod2pm = "98";
  var internet2pm = "43";



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

  Timer timer;

  Animation<Color> animation;
  AnimationController controller;

  Widget liveResult(){
    return Container(
        padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
        child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return new Container(
                child: Center(child: Text(live2dDigit,style: liveTextStyle(animation)),)
              );
            }),
    );
  }

  Widget updatedTime(){
    return Center(child: Text('Updated on '+live2dUpdateTime),);
  }

  Widget setTable12PM(){
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Text("12:01 PM",style: setTableTitleStyle,),
            Divider(),
            Row(
              children: [
                Expanded(flex: 2, child:Text("SET",style: setTableSubTitleStyle,)),
                Expanded(flex: 2,child: Text("Value",style: setTableSubTitleStyle,)),
                Expanded(flex: 1,child: Text("2D",style: setTableSubTitleStyle,)),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(flex: 2, child:Text(set12pm,style: setTableTitleStyle,)),
                Expanded(flex: 2,child: Text(val12pm,style: setTableTitleStyle,)),
                Expanded(flex: 1,child: Text(digit12pm,style: setTableTitleStyle,)),
              ],
            )
          ],
        ),
      );
  }
  Widget setTable4PM(){
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Text("4:30 PM",style: setTableTitleStyle,),
          Divider(),
          Row(
            children: [
              Expanded(flex: 2, child:Text("SET",style: setTableSubTitleStyle,)),
              Expanded(flex: 2,child: Text("Value",style: setTableSubTitleStyle,)),
              Expanded(flex: 1,child: Text("2D",style: setTableSubTitleStyle,)),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(flex: 2, child:Text(set4pm,style: setTableTitleStyle,)),
              Expanded(flex: 2,child: Text(val4pm,style: setTableTitleStyle,)),
              Expanded(flex: 1,child: Text(digit4pm,style: setTableTitleStyle,)),
            ],
          )
        ],
      ),
    );
  }

  Widget setTable9AM(){
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Text("9:30 AM",style: setTableTitleStyle,),
          Expanded(
            child: Column(
              children: [
                Text("Modern",style: setTableSubTitleStyle,),
                Divider(),
                Text(mod9am,style: setTableTitleStyle,)
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text("Internet",style: setTableSubTitleStyle,),
                Divider(),
                Text(internet9am,style: setTableTitleStyle,)
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget setTable2PM(){
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Text("2:00 PM",style: setTableTitleStyle,),
          Expanded(
            child: Column(
              children: [
                Text("Modern",style: setTableSubTitleStyle,),
                Divider(),
                Text(mod2pm,style: setTableTitleStyle,)
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text("Internet",style: setTableSubTitleStyle,),
                Divider(),
                Text(internet2pm,style: setTableTitleStyle,)
              ],
            ),
          ),
        ],
      ),
    );
  }


  String getRandomStr(int count,int max){
    var str ="";
    Random rand = new Random();
    str = rand.nextInt(max).toString();
    while(str.length < count){
      str = "0"+str;
    }
    return str;
  }
  void _startTimer(){
    timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      /*
      Random rand = new Random();
      var digit = rand.nextInt(100).toString();
      if(digit.length == 1 ) digit = "0"+digit;
      //print(timer.tick.toString());
       */

      //var dt = new DateTime.now();
      //var dtStr = dt.toString();
      setState(() {
        live2dDigit = getRandomStr(2, 100);
        live2dUpdateTime = "အင်တာနက် ချိတ်ဆက်နေပါသည်.....";
        set12pm = getRandomStr(2, 10000);;
        val12pm = getRandomStr(2, 10000);;
        digit12pm = getRandomStr(2, 100);;
        set4pm = getRandomStr(2, 10000);;
        val4pm = getRandomStr(2, 1000);;
        digit4pm = getRandomStr(2, 100);;
        mod9am = getRandomStr(2, 100);;
        internet9am = getRandomStr(2, 100);;
        mod2pm = getRandomStr(2, 100);;
        internet2pm = getRandomStr(2, 100);;
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
      live2dDigit = msg['live2d'].toString();
      live2dUpdateTime = dtStr;
      set12pm = msg['morningSet'].toString();
      val12pm = msg['morningValue'].toString();
      digit12pm = msg['morningDigit'].toString();
      set4pm = msg['eveningSet'].toString();
      val4pm = msg['eveningValue'].toString();
      digit4pm = msg['eveningDigit'].toString();
      mod9am = getRandomStr(2, 100);;
      internet9am = getRandomStr(2, 100);;
      mod2pm = getRandomStr(2, 100);;
      internet2pm = getRandomStr(2, 100);;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    print("initState in live2dresult");
    _startTimer();
    socket = io('https://shan-server.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.connect();

    socket.on('connect',(_){
      print("socket connected");
    });

    socket.on('connect_error',(_){
      print("socket connect error in live2dresult ");
      print(_.toString());
    });

    socket.on('data',(msg){
      print("socket on data event received");
      //print(msg);
      _receiveMessage(msg);
    });

    super.initState();

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


  /*
  AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Container(
            child: Text('Blinking Text Animation',
                style: TextStyle(color: animation.value, fontSize: 27)),
          );
        }),
   */

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        liveResult(),
        updatedTime(),
        setTable12PM(),
        setTable4PM(),
        setTable9AM(),
        setTable2PM()
      ],
    );
  }
}

class liveData {
  final String live2d;

  liveData(this.live2d);

  liveData.fromJson(Map<String, dynamic> json)
      : live2d = json['live2d'];

  Map<String, dynamic> toJson() =>
      {
        'live2d': live2d,
      };
}
