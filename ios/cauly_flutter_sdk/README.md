# 목차
1. [CAULY Flutter 시작하기](#1-CAULY-Flutter-시작하기)
    * [참고 사항](#참고-사항)
    * [권장 환경](#권장-환경)
    * [주의 사항](#주의-사항)
    * [SDK 구성](#SDK-구성)
    * [SDK 설치 방법](#SDK-설치-방법)

2. [배너 및 전면 광고 추가하기(Objective C 진영 연결 코드)](#2-배너-및-전면-광고-추가하기(Objective-C-진영-연결-코드))
    * [Flutter App 프로젝트루트경로/ios/Runner/FLNativeView.h 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter App 프로젝트루트경로/ios/Runner/FLNativeView.m 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter App 프로젝트루트경로/ios/Runner/AppDelegate.h 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter App 프로젝트루트경로/ios/Runner/AppDelegate.m 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)

3. [배너 및 전면 광고 추가하기(dart 진영 연결 코드)](#3-배너-및-전면-광고-추가하기(dart-진영-연결-코드)) 
    * [Flutter App 프로젝트루트경로/lib/main.dart 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)

4. [실행하기](#4-실행하기)
    * [Flutter App 프로젝트 실행을 위한 명령어 실행](#Flutter-App-프로젝트-실행을-위한-명령어-실행)

- - - 
# 1. CAULY Flutter 시작하기
이 프로젝트는 Cauly iOS SDK Flutter 연동 예제 프로젝트입니다.
Flutter 예제는 Flutter App 프로젝트이며, iOS SDK 10.0, Objective C 기반으로 작성 되었습니다.

### 참고 사항
- Cauly SDK는 iOS SDK 10.0 기반으로 작성 되었습니다.
- 기존 프로젝트에 있던 과거 SDK를 깨끗하게 지운 후 설치해야 정상 동작 됩니다.
- 새 SDK를 설치해도 기존 Library를 참조하는 경우 다음 작업을 수행 합니다.
	- [Targets 에서 “Get Info”]
		- “Build Phase” 탭 에서 Linked Libraries에 기존 라이브러리가 포함된 게 있다면 삭제 합니다.
		- “Build Settings” 탭에서 “Library Search Paths” 검색하여 불필요한 경로 삭제 합니다.
				원하는 경로가 제일 위로 가야 합니다.
- 배너광고 최소 요청 주기 15 초 입니다.

### 권장 환경
- Xcode 13.2.1 이상 사용
- iOS 10.0 이상 타겟팅

### 주의 사항
- SKAdNetwork 지원
	- Info.plist 파일에 SKAdNetworkItems 키를 추가하고 Cauly (55644vm79v.skadnetwork) 에 대한 SKAdNetworkIdentifier 값과 함께 Cauly 의 파트너 DSP 의 SKAdNetworkIdentifier 값을 추가합니다.
	- 즉, Info.plist 파일에 아래 내용을 추가해주시면 Cauly 와 Cauly 를 통한 다른 DSP 의 광고가 정상적으로 처리될 수 있습니다.
		
	```xml
	<key>SKAdNetworkItems</key>
	<array>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>55644vm79v.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>4fzdc2evr5.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>4pfyvq9l8r.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>v72qych5uu.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>6xzpu9s2p8.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>ludvb6z3bs.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>mlmmfzh3r3.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>294l99pt4k.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>24t9a8vw3c.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>hs6bdukanm.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>cstr6suwn9.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>54nzkqm89y.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>wzmmz9fp6w.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>yclnxrl5pm.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>7ug5zh24hu.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>feyaarzu9v.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>kbd757ywx3.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>275upjj5gd.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>9t245vhmpl.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>44jx6755aq.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>tl55sbb4fm.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>2u9pt9hc89.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>8s468mfl3y.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>74b6s63p6l.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>uw77j35x4d.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>gvmwg8q7h5.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>gta9lk7p23.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>32z4fx6l9h.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>3rd42ekr43.skadnetwork</string>
		</dict>
	</array>
	```	

- iOS9 ATS(App Transport Security) 처리
	- 애플은 iOS9 에서 ATS(App Transport Security)라는 기능을 제공합니다. 기기에서 ATS 활성화 시 암호화된 HTTPS 방식만 허용됩니다. HTTPS 방식을 적용하지 않을 경우 애플 보안 기준을 충족하지 않는다는 이유로 광고가 차단될 수 있습니다.
	- 모든 광고가 HTTPS 방식으로 호출되지 않으므로, info.plist 파일에 아래 설정을 적용하여 사용 부탁 드립니다.
	- (추가) 2017년 1월 이후 ATS를 활성화한 앱에 대해서만 앱스토어에 등록할 수 있도록한 애플 정책이 수립되었습니다. 따라서 기존 설정과 함께 추가적인 설정을 추가하여야 합니다.
	
	```xml
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
	```

	- BGM이 포함된 광고가 있을 수 있으니, APP에 BGM이 있는 경우 willShowLandingView API를 이용하여 일시 중지 해주세요, 그리고 광고 종료 후 didCloseLandingView API를 이용하여 BGM을 재 시작 하시면 됩니다.
	- 광고뷰가 화면에 보여지지 않는 경우에도 광고 요청을 할 수 있습니다. 광고 요청을 중단하고자 할 때 [CaulyAdView 객체 stopAdRequest]; 명령을 실행하여 광고 요청을 반드시 중지하기 바랍니다.
	- libCauly-universal.a 는 simulator와 device 통합된 파일 입니다. 
	- libCauly.a, libCauly-universal.a, Cauly.xcframework 파일 중 환경에 맞는 파일을 사용하시면 됩니다.


- iOS14 ATT(App Tracking Transparency) Framework 적용
	- 애플은 iOS14 에서 ATT(App Tracking Transparency) Framework가 추가되었습니다.
	- IDFA 식별자를 얻기 위해서는 `ATT Framework를 반드시 적용`해야 합니다.
	- `info.plist`
	```xml
	<key> NSUserTrackingUsageDescription </key>
	<string> 맞춤형 광고 제공을 위해 사용자의 데이터가 사용됩니다. </string>
	```

- 사용자 앱 내 광고 경험 개선을 위한 URL Scheme 적용
	- info.plist 작성
	```xml
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>naversearchapp</string>
	</array>
	```

### SDK 구성
- Cauly SDK 헤더 파일

| 파일명                   | 설명                       |
|-----------------------|--------------------------|
| Cauly.h               | Cauly SDK 공용 헤더 파일       |
| CaulyAdSetting.h      | Cauly 광고 세팅 클래스 헤더 파일    |
| CaulyAdView.h         | 광고 광고 클래스 및 프로토콜 헤더 파일   |
| CaulyInterstitialAd.h | 전면 광고 클래스 및 프로토콜 헤더 파일   |
| CaulyNativeAd.h       | 네이티브 광고 클래스 및 프로토콜 헤더 파일 |
| CaulyNativeAdItem.h   | 네이티브 광고 아이템 헤더 파일        |

- Cauly SDK 라이브러리 파일

| 파일명                  | 설명                                   |
|----------------------|--------------------------------------|
| libCauly.a           | Cauly SDK 라이브러리 파일 (디바이스 전용)         |
| libCauly-universal.a | Cauly SDK 라이브러리 파일 (시뮬레이터 및 디바이스 통합) |
| Cauly.xcframework    | Cauly SDK Framework 파일	(ARM64 계열 macOS 지원)	|
		
- Cauly SDK 샘플 프로젝트

  - Objective-C Project
  - Swift Project
	
## SDK 설치 방법
1. Cauly SDK 추가
	- Cauly SDK 를 적용할 프로젝트 내에 ‘CaulyLib’ 폴더 복사
	- Cauly.xcframework 추가 (ARM64 계열`M1, M2` macOS 지원)
2. Framework 추가
	- AVKit.framework
	- UIKit.framework
	- Foundation.framework
	- CoreGraphics.framework
	- QuartzCore.framework
	- SystemConfiguration.framework
	- MediaPlayer.framework
	- CFNetwork.framework
	- MessageUI.framework  //‘Required’ 를 ‘Optional’로 변경해야 합니다.
	- EventKit.framework    // ‘Required’ 를 ‘Optional’로 변경해야 합니다.
	- AdSupport.Framwork  // ‘Required’ 를 ‘Optional’로 변경해야 합니다.









# 2. 배너 및 전면 광고 추가하기(Objective C 진영 연결 코드)

XCode의 Objective C 파일은 Cauly iOS SDK의 기능인 배너 및 전면 광고 호출하는 역할을 담당합니다.
dart 파일에는 사용자와 상호작용할 수 있는 UI코드가 들어가며, Objective C 파일은 사용자가 UI를 통해 배너 및 전면 광고를 호출한 것과 일치하는 Cauly iOS SDK 를 호출할 수 있습니다.
dart 파일과 연결을 위해서 필요한 Objective C 파일을 수정 혹은 생성합니다.(총 12개의 파일 구현이 필요)

#### Flutter App 프로젝트루트경로/ios/Runner/FLNativeView.h 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` objectivec
//
//  FLNativeView.h
//  Runner
//
#import <Flutter/Flutter.h>
#import "Cauly.h"
#import "CaulyAdView.h"
#import "CaulyInterstitialAd.h"
#import "CaulyNativeAd.h"

@interface FLNativeViewFactory : NSObject <FlutterPlatformViewFactory, CaulyAdViewDelegate, CaulyNativeAdDelegate>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

@interface FLNativeView : NSObject <FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

- (UIView*)view;

- (CaulyAdView*)caulyAdView;

@end

```

#### Flutter App 프로젝트루트경로/ios/Runner/FLNativeView.m 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` objectivec
//
//  FLNativeView.m
//  Runner
//
#import "FLNativeView.h"

/**
 Flutter Native View 생성을 위한 클래스
 */
@implementation FLNativeViewFactory {
    NSObject<FlutterBinaryMessenger>* _messenger;
    FLNativeView* _flNativeView;
}

/**
 Flutter Native View Factory 초기화 메서드
 */
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

/**
 Flutter Native Platform View 생성 메서드
 */
- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    
    // 1. Create Flutter Native View
    NSLog(@"[HelloCauly]FLNativeViewFactory init().");
    _flNativeView = [[FLNativeView alloc] initWithFrame:frame
                                        viewIdentifier:viewId
                                             arguments:args
                                        binaryMessenger:_messenger];
    
    // 2. Set CaulyAdView callbacks to FlutterNativeViewFactory
    _flNativeView.caulyAdView.delegate = self;

    // 3. Start Cauly Ad Banner Request
    NSLog(@"[HelloCauly]CaulyAdView startBannerAdRequest() start.");
    [_flNativeView.caulyAdView startBannerAdRequest];
    NSLog(@"[HelloCauly]CaulyAdView startBannerAdRequest() finish.");
    
    return _flNativeView;
}

/**
 Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
 */
- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

#pragma - CaulyAdViewDelegate
// 배너 광고 정보 수신 성공
- (void)didReceiveAd:(CaulyAdView *)adView isChargeableAd:(BOOL)isChargeableAd {
  NSLog(@"[HelloCauly]didReceiveAd");
}

// 배너 광고 정보 수신 실패
- (void)didFailToReceiveAd:(CaulyAdView *)adView errorCode:(int)errorCode errorMsg:(NSString *)errorMsg {
  NSLog(@"[HelloCauly]didFailToReceiveAd : %d(%@)", errorCode, errorMsg);
}

// fullsite 혹은 rich 배너 광고 랜딩 화면 표시
- (void)willShowLandingView:(CaulyAdView *)adView {
  NSLog(@"[HelloCauly]willShowLandingView");
}

// fullsite 혹은 rich 배너 광고 랜딩 화면 닫음
- (void)didCloseLandingView:(CaulyAdView *)adView {
  NSLog(@"[HelloCauly]didCloseLandingView");
}

#pragma - CaulyNativeAdDelegate
- (void)didReceiveNativeAd:(CaulyNativeAd *)nativeAd isChargeableAd:(BOOL)isChargeableAd{
  NSLog(@"[HelloCauly]didReceiveNativeAd");
}

-(void)didFailToReceiveNativeAd:(CaulyNativeAd *)nativeAd errorCode:(int)errorCode errorMsg:(NSString *)errorMsg{
  NSLog(@"[HelloCauly]didFailToReceiveNativeAd");
}

@end


/**
 Flutter Native View 클래스
 */
@implementation FLNativeView {
    UIView *_view;
    CaulyAdView *_caulyAdView;
}

/**
 Flutter Native View 초기화 메서드
 */
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    
  if (self = [super init]) {
      
      // 1. create empty UIView
      _view = [[UIView alloc] init];
      
      // 2. create CaulyAdView
      NSLog(@"[HelloCauly]CaulyAdView init() start.");
      _caulyAdView = [[CaulyAdView alloc] initWithParentViewController:self];
      _caulyAdView.frame = _view.bounds;
      NSLog(@"[HelloCauly]CaulyAdView init() finish.");

      // 3. Attach CaulyAdView to UIView
      NSLog(@"[HelloCauly]CaulyAdView addSubView() start.");
      [_view addSubview:_caulyAdView];
      NSLog(@"[HelloCauly]CaulyAdView addSubView() finish.");
      _caulyAdView.frame = _view.bounds;
      [_view bringSubviewToFront:_caulyAdView];
      
//      printf(@"args = %@ ", args[0]);
  }
  return self;
}

/**
 Flutter Native View의 루트 뷰 getter
 */
- (UIView*)view {
  return _view;
}

/**
 루트 뷰에 속한 CaulyAdView getter
 */
-(CaulyAdView*)caulyAdView {
    return _caulyAdView;
}

@end
```

#### Flutter App 프로젝트루트경로/ios/Runner/AppDelegate.h 수정 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` objectivec
//
//  AppDelegate.h
//  Runner
//
#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

#import "Cauly.h"
#import "CaulyAdView.h"
#import "CaulyInterstitialAd.h"
#import "CaulyNativeAd.h"

@interface AppDelegate : FlutterAppDelegate
@property (strong, nonatomic) CaulyAdSetting *adSetting;
@property (strong, nonatomic) CaulyInterstitialAd *caulyInterstitialAd;
@end

@interface CaulyInterstitialAdCallback : NSObject <CaulyInterstitialAdDelegate>
@property (strong, nonatomic) CaulyInterstitialAd *caulyInterstitialAd;
- (instancetype)init:(CaulyInterstitialAd*)caulyInterstitialAd;
- (void)show;
@end
```

#### Flutter App 프로젝트루트경로/ios/Runner/AppDelegate.m 수정 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` objectivec
//
//  AppDelegate.m
//  Runner
//

#import "AppDelegate.h"
#import "FLNativeView.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate {
    CaulyInterstitialAd* _caulyInterstitialAd;
    CaulyInterstitialAdCallback* _caulyInterstitialAdCallback;
}

/**
 main dart 파일에서 설정한 @"samples.flutter.dev/initialize" 채널을 통해서 메서드를 호출할 때 가장 먼저 불리는 메서드
 */
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    // 1. initialize method
    FlutterMethodChannel *initializeChannel = [FlutterMethodChannel                             methodChannelWithName:@"samples.flutter.dev/caulyIos" binaryMessenger:controller.binaryMessenger];
    
    // 2. result callback
    [initializeChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        if ([@"initialize" isEqualToString:call.method]) {
        
            // parse arguments
            NSString *identifier = [[call.arguments objectForKey:@"identifier"] stringValue];
            NSString *code = [[call.arguments objectForKey:@"code"] stringValue];
            BOOL useDynamicReload = [[call.arguments objectForKey:@"useDynamicReload"] boolValue];
            BOOL closeLanding = [[call.arguments objectForKey:@"closeLanding"] boolValue];
            CaulyAnim animation = CaulyAnimNone;
            CaulyAdSize size = CaulyAdSize_IPhone;
            CaulyReloadTime reloadTime = CaulyReloadTime_30;
            CaulyLogLevel logLevel = CaulyLogLevelTrace;
            
            // call Cauly initialize
            NSString *caulyAdSettingDesc = [self initialize:identifier appCode:code animType:animation adSize:size reloadTime:reloadTime useDynamicReloadTime:useDynamicReload closeOnLanding:closeLanding logLevel:logLevel];
            
            // send result
            if ([caulyAdSettingDesc length] != 0) {
                result(caulyAdSettingDesc);
            } else {
                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                           message:@"initialize failed."
                                           details:nil]);
            }
            
        } else if([@"requestInterstitialAd" isEqualToString:call.method]) {
            // parse arguments
            NSString *identifier = [[call.arguments objectForKey:@"identifier"] stringValue];
            NSString *code = [[call.arguments objectForKey:@"code"] stringValue];
            BOOL useDynamicReload = [[call.arguments objectForKey:@"useDynamicReload"] boolValue];
            BOOL closeLanding = [[call.arguments objectForKey:@"closeLanding"] boolValue];
            CaulyAnim animation = CaulyAnimNone;
            CaulyAdSize size = CaulyAdSize_IPhone;
            CaulyReloadTime reloadTime = CaulyReloadTime_30;
            CaulyLogLevel logLevel = CaulyLogLevelTrace;
            
            // call Cauly initialize
            NSString *caulyAdSettingDesc = [self initialize:identifier appCode:code animType:animation adSize:size reloadTime:reloadTime useDynamicReloadTime:useDynamicReload closeOnLanding:closeLanding logLevel:logLevel];
            
            // send result
            if ([caulyAdSettingDesc length] != 0) {
                [self requestInterstitialAd:controller];
                result(caulyAdSettingDesc);
            } else {
                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                           message:@"initialize failed."
                                           details:nil]);
            }
            

        } else if([@"showInterstitialAd" isEqualToString:call.method]) {
            NSLog(@"[HelloCauly]AppDelegate showInterstitialAd() start.");
            if(_caulyInterstitialAdCallback != nil) {
                NSLog(@"[HelloCauly]CaulyInterstitialCallback.show() started.");
                [_caulyInterstitialAdCallback show];
                NSLog(@"[HelloCauly]CaulyInterstitialCallback.show() finished.");
            }
            NSLog(@"[HelloCauly]AppDelegate showInterstitialAd() finished.");
        } else {
            // send result
            result(FlutterMethodNotImplemented);
        }
    }];
    
    
    // 3. register banner view flutter plugin
    NSObject<FlutterPluginRegistrar>* registrar =
       [self registrarForPlugin:@"CaulyBannerPlugin"];

    // 4. initialize flutter native view factory
    FLNativeViewFactory* factory =
       [[FLNativeViewFactory alloc] initWithMessenger:registrar.messenger];
    [registrar registerViewFactory:factory withId:@"bannerViewType"];
    
    // 5. return
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

/**
Cauly Banner 혹은 Interstitial 광고 호출 전 CaulyAdSetting 호출하여 광고 설정을 하는 메서드
 */
- (NSString *) initialize: (NSString *)identifier appCode: (NSString *)code animType:(CaulyAnim)animation adSize:(CaulyAdSize)size reloadTime:(CaulyReloadTime)reloadTime useDynamicReloadTime:(BOOL)useDynamicReload closeOnLanding:(BOOL)closeLanding logLevel:(CaulyLogLevel)logLevel {
    
    NSLog(@"[HelloCauly]CaulyAdSetting for Flutter has been started.");
    
    _adSetting = [CaulyAdSetting globalSetting];
    
    // 카울리 로그 레벨
    [CaulyAdSetting setLogLevel:logLevel];
    
    // iTunes App ID
    _adSetting.appId = identifier;
    
    // 카울리 앱 코드
    _adSetting.appCode = code;
    
    // 화면 전환 효과
    _adSetting.animType = animation;
    
    // 광고 View 크기
    _adSetting.adSize = size;
    
    // 광고 자동 갱신 시간 (기본값)
    _adSetting.reloadTime = reloadTime;
    
    // 광고 자동 갱신 사용 여부 (기본값)
    _adSetting.useDynamicReloadTime = useDynamicReload;
    
    // 광고 랜딩 시 WebView 제거 여부
    _adSetting.closeOnLanding = closeLanding;
    
    NSLog(@"[HelloCauly]CaulyAdSetting for Flutter has been finished successfully.");
    
    return [NSString stringWithFormat:@"CaulyAdSetting: appId=%@ appCode=%@ animType=%d adSize=%d reloadTime=%d useDynamicReloadTime=%d closeOnLanding=%d", _adSetting.appId, _adSetting.appCode, _adSetting.animType, _adSetting.reloadTime, (int)_adSetting.useDynamicReloadTime, (int)_adSetting.closeOnLanding];
}

- (void) requestInterstitialAd: (FlutterViewController*)controller {
    
    NSLog(@"[HelloCauly]AppDelegate requestInterstitialAd");
    if (_caulyInterstitialAd) {
        _caulyInterstitialAd = nil;                                                          // 전면 광고 객체 제거
    }

    NSLog(@"[HelloCauly]CaulyInterstitialAd initWithParentViewController() start.");
    _caulyInterstitialAd = [[CaulyInterstitialAd alloc] initWithParentViewController:controller];  // 전면 광고 객체 생성
    _caulyInterstitialAdCallback = [[CaulyInterstitialAdCallback alloc]init:_caulyInterstitialAd]; // 전면 delegate 설정
    _caulyInterstitialAd.delegate = _caulyInterstitialAdCallback;
    NSLog(@"[HelloCauly]CaulyInterstitialAd initWithParentViewController() finish.");
    
    NSLog(@"[HelloCauly]CaulyInterstitialAd startInterstitialAdRequest() start.");
    [_caulyInterstitialAd startInterstitialAdRequest];                                       // 전면 광고 요청
    NSLog(@"[HelloCauly]CaulyInterstitialAd startInterstitialAdRequest() finish.");
}

@end

@implementation CaulyInterstitialAdCallback

- (instancetype)init:(CaulyInterstitialAd*)caulyInterstitialAd {
    self = [super init];
    if (self) {
        _caulyInterstitialAd = caulyInterstitialAd;
    }
    return self;
}

- (void)show {
    [_caulyInterstitialAd show];
}

#pragma - CaulyInterstitialAdDelegate
- (void)didReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd isChargeableAd:(BOOL)isChargeableAd{
    NSLog(@"[HelloCauly]didReceiveInterstitialAd");
    _caulyInterstitialAd = interstitialAd;
    
}

- (void)didFailToReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd errorCode:(int)errorCode errorMsg:(NSString *)errorMsg{
    NSLog(@"[HelloCauly]didFailToReceiveInterstitialAd");
    
}

- (void)willShowInterstitialAd:(CaulyInterstitialAd *)interstitialAd{
    NSLog(@"[HelloCauly]willShowInterstitialAd");
    
}

- (void)didCloseInterstitialAd:(CaulyInterstitialAd *)interstitialAd{
    NSLog(@"[HelloCauly]didCloseInterstitialAd");
    _caulyInterstitialAd = nil;
    
}

@end

```


# 3. 배너 및 전면 광고 추가하기(dart 진영 연결 코드)

Objective C 파일을 완성하였다면, Objective C 파일을 호출할 dart 파일을 만들어줍니다.
dart 파일은 사용자와 직접 상호작용하는 UI코드가 포함되어 있으며, UI를 통해 사용자와 Objective C 파일 사이에서 일어나는 배너 및 전면 광고 호출 활동을 연결해주는 매개 역할을 합니다.

#### Flutter App 프로젝트루트경로/lib/main.dart 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` dart
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
```

# 4. 실행하기
마지막으로 Flutter App 프로젝트에서 요구되는 dependency(pubspec.yaml에 추가된 dependency들)를 추가하기 위해 다음 명령어를 순차적으로 실행합니다.
혹은 더 간단하게 실행하려면 xcode에서 실행버튼을 클릭하여 실행을 할 수도 있습니다.

### Flutter App 프로젝트 실행을 위한 명령어 실행
```
flutter clean
flutter pub get
```