import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:cauly_flutter_sdk/cauly_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BannerAd? _banner;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _createBanner();
  }

  void _createBanner() {
    _banner = BannerAd(
        listener: BannerAdListener(
          onReceiveAd: (ad) {
            debugPrint('BannerAdListener onReceiveAd!!!');
          },
          onFailedToReceiveAd: (ad, errorCode, errorMessage) {
            debugPrint('BannerAdListener onFailedToReceiveAd : $errorCode $errorMessage');
          },
          onCloseLandingScreen: (ad) {
            debugPrint('BannerAdListener onCloseLandingScreen!!!');
          },
          onShowLandingScreen: (ad) {
            debugPrint('BannerAdListener onShowLandingScreen!!!');
          },
        ),
        adInfo: const AdInfo("YOUR_CAULY_APP_CODE", BannerHeightEnum.adaptive, 320, 50))
      ..load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adInfo: const AdInfo(
            "YOUR_CAULY_APP_CODE",
            BannerHeightEnum.adaptive,
            320,
            50),
        adLoadCallback: InterstitialAdLoadCallback(
          onReceiveInterstitialAd: (ad) {
            debugPrint('InterstitialAd onReceiveInterstitialAd!!!');
            _interstitialAd = ad;
            if (_interstitialAd != null) {
              _interstitialAd!.show();
              _interstitialAd = null;
            }
          },
          onFailedToReceiveInterstitialAd: ((errorCode, errorMessage) {
            debugPrint('InterstitialAd onFailedToReceiveInterstitialAd: $errorMessage');
            _interstitialAd = null;
          }),
          onClosedInterstitialAd: (ad) {
            debugPrint('InterstitialAd onClosedInterstitialAd');
          },
          onLeaveInterstitialAd: (ad) {
            debugPrint('InterstitialAd onLeaveInterstitialAd');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.amber),
                child: Center(
                    child: ElevatedButton(
                        onPressed: () => _showInterstitialAd(),
                        child: const Text('광고 가자'))),
              ),
            ),
            _banner == null
                ? Container()
                : SizedBox(
              height: _banner!.bannerSizeHeight.toDouble(),
              child: AdWidget(ad: _banner!),
            )
          ],
        ),
      ),
    );
  }

  _showInterstitialAd() {
    if (_interstitialAd == null) {
      _createInterstitialAd();
    }
  }
}
