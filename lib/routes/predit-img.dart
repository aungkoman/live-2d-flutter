import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:live2d/drawer/customDrawer.dart';
import 'package:live2d/widgets/fabChatroom.dart';
import 'package:live2d/widgets/live2dresult.dart';


class preditImg extends StatefulWidget {
  preditImg({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _preditImgState createState() => _preditImgState();
}

class _preditImgState extends State<preditImg> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //drawer: customDrawer(),
      body: Center(
        child: Center(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: 'https://mmsoftware100.com/kozayya/upload/img.jpg',
          )
          /*
          child: CachedNetworkImage(
            imageUrl: "https://mmsoftware100.com/kozayya/upload/img.jpg",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Text("အင်တာနက် ဖွင့်ပြီးကြည့်ပါ..."),
          )

           */
        )
      ),
      floatingActionButton: fabChatroom(),
    );
  }
}
