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
                ElevatedButton(
                  onPressed: _showInterstitialAd,
                  child: const Text('Show Interstitial Ad'),
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
    Widget widget;
    try {
      final String result = await platform.invokeMethod('initialize', <String, dynamic>{'identifier':'CAULY', 'code': 'YOUR_CAULY_CODE', 'useDynamicReload': true, 'closeLanding': true });
      initializeBannerResult = 'initialize success! $result %';
      widget = _setBannerView();
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
