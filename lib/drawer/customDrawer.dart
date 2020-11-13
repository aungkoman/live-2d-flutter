import 'package:flutter/material.dart';

class customDrawer extends StatelessWidget {

  void _isSameRoute(String newRoute,BuildContext context){
    print("new Route "+newRoute);
    bool isSame = false;
    Navigator.popUntil(context, (route){
      if(route.settings.name == newRoute) isSame = true;
      return true;
    });
    if(!isSame) Navigator.pushNamed(context, newRoute);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Center(child: Text('2D/3D Live'),)),
          ListTile(
            leading: Icon(Icons.live_tv,color: Colors.blue),
            title: Text("နှစ်လုံးဂဏန်း တိုက်ရိုက်ကြည့်ရန်"),
            onTap: (){
              Navigator.pop(context);
              _isSameRoute('/live2d', context);
            },
          ),
          ListTile(
            leading: Icon(Icons.live_tv_outlined, color: Colors.red,),
            title: Text("သုံးလုံးဂဏန်း တိုက်ရိုက်ကြည့်ရန်"),
            onTap: (){
              Navigator.pop(context);
              _isSameRoute('/live3d', context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue,),
            title: Text("အတိတ်စိမ်း "),
            onTap: (){
              Navigator.pop(context);
              _isSameRoute('/predit-img', context);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_outlined, color: Colors.green,),
            title: Text("စကားပြောခန်း"),
            onTap: (){
              Navigator.pop(context);
              _isSameRoute('/chatroom', context);
            },
          ),
          ListTile(
            leading: Icon(Icons.table_chart_outlined, color: Colors.yellow,),
            title: Text("နှစ်လုံး ထွက်ခဲ့သမျှ"),
            onTap: (){
              Navigator.pop(context);
              _isSameRoute('/history2d', context);
            },
          ),
          ListTile(
            leading: Icon(Icons.table_chart_outlined, color: Colors.deepOrangeAccent,),
            title: Text("သုံးလုံး ထွက်ခဲ့သမျှ"),
            onTap: (){
              Navigator.pop(context);
              _isSameRoute('/history3d', context);
            },
          ),
          ListTile(
            leading: Icon(Icons.apps, color: Colors.blue,),
            title: Text("App အကြောင်း"),
            onTap: (){
              Navigator.pop(context);
              _isSameRoute('/aboutapp', context);
            },
          ),
        ],
      ),
    );
  }
}
