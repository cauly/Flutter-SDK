import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}



class _MyHomePageState extends State<MyHomePage> {
  static const String VIEW_TYPE = 'bannerViewType';

  // Pass parameters to the platform side.
  static const Map<String, dynamic> creationParams = <String, dynamic>{
    "param": "bannerViewParam"
  };
  
  static const platform = MethodChannel('samples.flutter.dev/caulyIos');
  // call initialize.
  String _initializeResult = 'initialize not yet.';
  Widget _widget = Container();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(),
        ),
        body: Material(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _initializeBannerRequest,
                  child: const Text('Banner Request'),
                ),
                ElevatedButton(
                  onPressed: _initializeInterstitialRequest,
                  child: const Text('Interstitial Request'),
                ),           
                Text(_initializeResult),
                _widget,
              ],
            ),
          ),
        ),
      ),
    );
  }  

  Future<void> _initializeBannerRequest() async {
    String initializeBannerResult;
    Widget widget = Container();
    try {
      final String result = await platform.invokeMethod('initialize', <String, dynamic>{'identifier':'CAULY', 'code': 'YOUR_CAULY_CODE', 'useDynamicReload': true, 'closeLanding': true });
      initializeBannerResult = 'initialize success! $result %';

      // show banner view 
      widget = _setBannerView();

      // set cauly interstitial ad listener
      platform.setMethodCallHandler((handler) async {
        if (handler.method == 'onReceiveAd') {
          // Do your logic here.
          initializeBannerResult += ' onReceiveAd';
          debugPrint('BannerAd onReceiveAd');
        } else if (handler.method == 'onFailToReceiveAd') {
          // Do your logic here.
          initializeBannerResult += ' onFailToReceiveAd';
          debugPrint('BannerAd onFailToReceiveAd');
        } else if (handler.method == 'onWillShowLandingView') {
          // Do your logic here.
          initializeBannerResult += ' onWillShowLandingView';          
          debugPrint('BannerAd onWillShowLandingView');
        } else if (handler.method == 'onDidCloseLandingView') {
          // Do your logic here.
          initializeBannerResult += ' onDidCloseLandingView';          
          debugPrint('BannerAd onDidCloseLandingView');
        } else if (handler.method == 'onDidReceiveNativeAd') {
          // Do your logic here.
          initializeBannerResult += ' onDidReceiveNativeAd';          
          debugPrint('BannerAd onDidReceiveNativeAd');
        } else if (handler.method == 'onDidFailToReceiveNativeAd') {
          // Do your logic here.
          initializeBannerResult += ' onDidFailToReceiveNativeAd';          
          debugPrint('BannerAd onDidFailToReceiveNativeAd');
        } else {
          initializeBannerResult += ' Unknown method from MethodChannel: ${handler.method}';
          debugPrint('Unknown method from MethodChannel: ${handler.method}');
        }
      });
    } on PlatformException catch (e) {
      initializeBannerResult = "Failed to initialize...: '${e.message}'.";
      widget = Container();
    }

    setState(() {
      _initializeResult = initializeBannerResult;
      _widget = widget;
    });
  }

  Widget _setBannerView() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return Container(
          width: double.maxFinite,
          height: 300,
          child: UiKitView(
            viewType: VIEW_TYPE,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        );
      case TargetPlatform.android:
        return Container(
          child: Center(
            child: Text('Android'),
          ),
        );
      default:
        return Container();
    }
  } 

  Future<void> _initializeInterstitialRequest() async {
    String initializeInterstitialResult;
    try {
      final String result = await platform.invokeMethod('requestInterstitialAd', <String, dynamic>{'identifier':'CAULY', 'code': 'YOUR_CAULY_CODE', 'useDynamicReload': false, 'closeLanding': true });
      initializeInterstitialResult = 'initialize success! $result %';

      // set cauly interstitial ad listener
      platform.setMethodCallHandler((handler) async {
        if (handler.method == 'onReceiveInterstitialAd') {
          // Do your logic here.
          initializeInterstitialResult += ' onReceiveInterstitialAd';
          debugPrint('InterstitialAd onReceiveInterstitialAd');

          // show interstitial ad
          _showInterstitialAd();
        } else if (handler.method == 'onFailToReceiveInterstitialAd') {
          // Do your logic here.
          initializeInterstitialResult += ' onFailToReceiveInterstitialAd';
          debugPrint('InterstitialAd onFailToReceiveInterstitialAd');
        } else if (handler.method == 'onWillShowInterstitialAd') {
          // Do your logic here.
          initializeInterstitialResult += ' onWillShowInterstitialAd';          
          debugPrint('InterstitialAd onWillShowInterstitialAd');
        } else if (handler.method == 'onDidCloseInterstitialAd') {
          // Do your logic here.
          initializeInterstitialResult += ' onDidCloseInterstitialAd';          
          debugPrint('InterstitialAd onDidCloseInterstitialAd');
        } else {
          initializeInterstitialResult += ' Unknown method from MethodChannel: ${handler.method}';
          debugPrint('Unknown method from MethodChannel: ${handler.method}');
        }
      });

    } on PlatformException catch (e) {
      initializeInterstitialResult = "Failed to initialize...: '${e.message}'.";
    }

    setState(() {
      _initializeResult = initializeInterstitialResult;
    });
  }   

  Future<void> _showInterstitialAd() async {
    try {
      await platform.invokeMethod('showInterstitialAd');
    } on PlatformException catch (e) {

    }
  }     
}
