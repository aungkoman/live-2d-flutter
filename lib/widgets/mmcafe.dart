import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
class mmcafe extends StatefulWidget {
  @override
  _mmcafeState createState() => _mmcafeState();
}

class _mmcafeState extends State<mmcafe> {
  final List<String> messageList = <String>["ကြိုဆိုပါတယ်","အားလုံးပဲ ကံကောင်းကြပါစေ"];

  final TextEditingController messageTextEditingController = new TextEditingController();
  final ScrollController messageListScrollController = new ScrollController();

  void _receiveMessage(String msg){
    setState(() {
      messageList.add(msg);
    });
    scrollToBottom();
  }

  Socket socket;
  @override
  void initState() {
    print("initState");
    //Creating the socket
    socket = io('https://shan-server.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.connect();

    socket.on('connect',(_){
      print("socket connected");
      socket.emit('flutter',"နေကောင်းကြရဲ့လားဗျ၊ ကျန်းမာရေး ဂရုစိုက်ပြီး အိမ်မှာ နေကြပါနော");
    });

    socket.on('connect_error',(_){
      print("socket connect error ");
      print(_.toString());
    });

    socket.on('flutter',(msg){
      print("socket on flutter event received");
      print(msg);
      _receiveMessage(msg);
    });
  }


  @override
  void dispose(){
    messageTextEditingController.dispose();
    messageListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: messageListView()),
        messageInputBox(),
      ],
    );
  }

  void sendMessage(){
    String msg = messageTextEditingController.text;
    if(msg.length == 0 ) return;
    setState(() {
        messageList.add(msg);
    });
    messageTextEditingController.clear();
    scrollToBottom();
    socket.emit('flutter',msg);
  }
  void scrollToBottom(){
    messageListScrollController.animateTo(
        messageListScrollController.position.maxScrollExtent+100,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn
    );
  }
  Widget messageListView() => ListView.separated(
      controller: messageListScrollController,
      itemBuilder: (BuildContext buildContext, int index){
        //return Center(child: Text(index.toString()));
        return Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(20, 8, 8, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey[100],
          ),
          child: Text(messageList[index]),
        );
      },

      separatorBuilder: (BuildContext buildContext, int index){
        return Divider(
          height: 1,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        );
      },
      itemCount: messageList.length
  );


  Widget messageInputBox() => Container(
    //color: Colors.redAccent,
    child: TextField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      controller: messageTextEditingController,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText : "Message",
        prefixIcon: Icon(Icons.message,color: Colors.blue,),
        suffixIcon: IconButton(
          onPressed: (){
            print("suffixIcon onPressed and clear input");
            sendMessage();
          },
          icon: Icon(Icons.send,color:Colors.blue),
        ),
        hintText: "Type your message here",
      ),
    ),
  );
}
