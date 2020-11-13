import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:live2d/drawer/customDrawer.dart';
import 'package:live2d/drawer/open-facebook.dart';
import 'package:live2d/widgets/fabChatroom.dart';
import 'package:live2d/widgets/live2dresult.dart';


class live2d extends StatefulWidget {
  live2d({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _live2dState createState() => _live2dState();
}

class _live2dState extends State<live2d> {
  int _counter = 0;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  AdmobReward rewardAd;

  bool bannerShow = true;
  int isInitialize = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bannerSize = AdmobBannerSize.BANNER;
    isInitialize++;

    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );

    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    );

    interstitialAd.load();
    rewardAd.load();
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
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
                (isInitialize % 2 == 0 ) ?  showIntersittialAd() : showRewardAd();
                isInitialize++;
                _isSameRoute('/live3d', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue,),
              title: Text("အတိတ်စိမ်း "),
              onTap: (){
                Navigator.pop(context);(isInitialize % 2 == 0 ) ?  showIntersittialAd() : showRewardAd();
                isInitialize++;
                _isSameRoute('/predit-img', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.chat_outlined, color: Colors.green,),
              title: Text("စကားပြောခန်း"),
              onTap: (){
                Navigator.pop(context);
                (isInitialize % 2 == 0 ) ?  showIntersittialAd() : showRewardAd();
                isInitialize++;
                _isSameRoute('/chatroom', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart_outlined, color: Colors.yellow,),
              title: Text("နှစ်လုံး ထွက်ခဲ့သမျှ"),
              onTap: (){
                Navigator.pop(context);
                (isInitialize % 2 == 0 ) ?  showIntersittialAd() : showRewardAd();
                isInitialize++;
                _isSameRoute('/history2d', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart_outlined, color: Colors.deepOrangeAccent,),
              title: Text("သုံးလုံး ထွက်ခဲ့သမျှ"),
              onTap: (){
                Navigator.pop(context);
                (isInitialize % 2 == 0 ) ?  showIntersittialAd() : showRewardAd();
                isInitialize++;
                _isSameRoute('/history3d', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.apps, color: Colors.blue,),
              title: Text("App အကြောင်း"),
              onTap: (){
                Navigator.pop(context);
                (isInitialize % 2 == 0 ) ?  showIntersittialAd() : showRewardAd();
                isInitialize++;
                OpenFacebook.openFacebook();
                _isSameRoute('/aboutapp', context);
              },
            ),
          ],
        ),
      ),
      //drawer: customDrawer(),
      body : Column(
          children: [
            Expanded(child: live2dresult()),
            Visibility(
              visible: bannerShow,
              child: Container(
                // margin: EdgeInsets.only(bottom: 20.0),
                child: AdmobBanner(
                  adUnitId: getBannerAdUnitId(),
                  adSize: bannerSize,
                  listener: (AdmobAdEvent event,Map<String, dynamic> args) {
                    print("listener AdmobAdEvent");
                    handleEvent(event, args, 'Banner');
                  },
                  onBannerCreated:
                      (AdmobBannerController controller) {
                    print("onBannerCreated");
                    if(isInitialize == 1){
                      isInitialize++;
                      setState(() {
                        bannerShow = false;
                      });
                    }

                    // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                    // Normally you don't need to worry about disposing this yourself, it's handled.
                    // If you need direct access to dispose, this is your guy!
                    // controller.dispose();
                  },
                ),
              ),
            ),
          ]
      ),
      /*
      body: Center(
        child: Center(
          child: Text("Live 2D"),
        )
      ),
       */

      floatingActionButton: fabChatroom(),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/chatroom');
        },
        tooltip: 'Chat Room',
        child: Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
       */
    );
  }


  void showSnackBar(String content) {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7499955469448445/5071045465';
    }
    return null;
  }


  String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7499955469448445/9159831266';
    }
    return null;
  }


  String getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7499955469448445/7286145265';
    }
    return null;
  }

  void handleEvent(AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        setState(() {
          bannerShow = true;
        });
        //showSnackBar('New Admob $adType Ad loaded!');
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
      //showSnackBar('Admob $adType Ad opened!');
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
      //showSnackBar('Admob $adType Ad closed!');
        print('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        print("AdmobAdEvent.failedToLoad : setState false");
        setState(() {
          bannerShow = false;
        });
        //showSnackBar('Admob $adType failed to load. :(');
        print('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showSnackBar('Admob $adType rewared');
        /*
        showDialog(
          context: scaffoldState.currentContext,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
              onWillPop: () async {
                scaffoldState.currentState.hideCurrentSnackBar();
                return true;
              },
            );
          },
        );

         */
        break;
      default:
    }
  }

  Future<void> showIntersittialAd() async{
    if (await interstitialAd.isLoaded) {
      interstitialAd.show();
      //return true;
    } else {
      print('Interstitial ad is still loading...');
      // showSnackBar('Interstitial ad is still loading...');
      // return false;
    }
  }

  Future<void> showRewardAd() async {
    if (await rewardAd.isLoaded) {
      rewardAd.show();
    } else {
      // showSnackBar('Reward ad is still loading...');
      print('Reward ad is still loading...');
    }
  }
}



