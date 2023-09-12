#import "AppDelegate.h"
#import "FLNativeView.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate {
    CaulyInterstitialAdCallback* _caulyInterstitialAdCallback;
}

/**
 main dart 파일에서 설정한 @"samples.flutter.dev/initialize" 채널을 통해서 메서드를 호출할 때 가장 먼저 불리는 메서드
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    
    _flutterViewController = (FlutterViewController*)self.window.rootViewController;
    
    // 1. initialize method
    _flutterMethodChannel = [FlutterMethodChannel methodChannelWithName:@"samples.flutter.dev/caulyIos" binaryMessenger:_flutterViewController.binaryMessenger];
    
    // 2. result callback
    [_flutterMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
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
            NSString *caulyAdSettingDesc = [weakSelf initialize:identifier appCode:code animType:animation adSize:size reloadTime:reloadTime useDynamicReloadTime:useDynamicReload closeOnLanding:closeLanding logLevel:logLevel];
            
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
            NSString *caulyAdSettingDesc = [weakSelf initialize:identifier appCode:code animType:animation adSize:size reloadTime:reloadTime useDynamicReloadTime:useDynamicReload closeOnLanding:closeLanding logLevel:logLevel];
            
            // send result
            if ([caulyAdSettingDesc length] != 0) {
                [weakSelf requestInterstitialAd];
                result(caulyAdSettingDesc);
            } else {
                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                           message:@"initialize failed."
                                           details:nil]);
            }
            

        } else if([@"showInterstitialAd" isEqualToString:call.method]) {
            NSLog(@"[HelloCauly]AppDelegate showInterstitialAd() start.");
            if(self -> _caulyInterstitialAdCallback != nil) {
                NSLog(@"[HelloCauly]CaulyInterstitialCallback.show() started.");
                [weakSelf -> _caulyInterstitialAdCallback show];
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
    [[FLNativeViewFactory alloc] initWithMessenger:registrar.messenger flutterMethodChannel:_flutterMethodChannel];
    [registrar registerViewFactory:factory withId:@"bannerViewType"];
    
    // 5. return
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

/**
Cauly Banner 혹은 Interstitial 광고 호출 전 CaulyAdSetting 호출하여 광고 설정을 하는 메서드
 */
- (NSString *) initialize: (NSString *)identifier appCode: (NSString *)code animType:(CaulyAnim)animation adSize:(CaulyAdSize)size reloadTime:(CaulyReloadTime)reloadTime useDynamicReloadTime:(BOOL)useDynamicReload closeOnLanding:(BOOL)closeLanding logLevel:(CaulyLogLevel)logLevel {
    
    NSLog(@"[HelloCauly]CaulyAdSetting for Flutter has been started.");
    
    _caulyAdSetting = [CaulyAdSetting globalSetting];
    
    // 카울리 로그 레벨
    [CaulyAdSetting setLogLevel:logLevel];
    
    // iTunes App ID
    _caulyAdSetting.appId = identifier;
    
    // 카울리 앱 코드
    _caulyAdSetting.appCode = code;
    
    // 화면 전환 효과
    _caulyAdSetting.animType = animation;
    
    // 광고 View 크기
    _caulyAdSetting.adSize = size;
    
    // 광고 자동 갱신 시간 (기본값)
    _caulyAdSetting.reloadTime = reloadTime;
    
    // 광고 자동 갱신 사용 여부 (기본값)
    _caulyAdSetting.useDynamicReloadTime = useDynamicReload;
    
    // 광고 랜딩 시 WebView 제거 여부
    _caulyAdSetting.closeOnLanding = closeLanding;
    
    NSLog(@"[HelloCauly]CaulyAdSetting for Flutter has been finished successfully.");
    
    return [NSString stringWithFormat:@"CaulyAdSetting: appId=%@ appCode=%@ animType=%d adSize=%d reloadTime=%d useDynamicReloadTime=%d closeOnLanding=%d", _caulyAdSetting.appId, _caulyAdSetting.appCode, _caulyAdSetting.animType, _caulyAdSetting.adSize, _caulyAdSetting.reloadTime, (int)_caulyAdSetting.useDynamicReloadTime, (int)_caulyAdSetting.closeOnLanding];
}

- (void) requestInterstitialAd {
    
    NSLog(@"[HelloCauly]AppDelegate requestInterstitialAd");
    if (_caulyInterstitialAd) {
        _caulyInterstitialAd = nil;                                                          // 전면 광고 객체 제거
    }

    NSLog(@"[HelloCauly]CaulyInterstitialAd initWithParentViewController() start.");
    _caulyInterstitialAd = [[CaulyInterstitialAd alloc] initWithParentViewController:_flutterViewController];  // 전면 광고 객체 생성
    
    _caulyInterstitialAdCallback = [[CaulyInterstitialAdCallback alloc] init:_caulyInterstitialAd flutterMethodChannel:_flutterMethodChannel]; // 전면 delegate 설정
    _caulyInterstitialAd.delegate = _caulyInterstitialAdCallback;
    NSLog(@"[HelloCauly]CaulyInterstitialAd initWithParentViewController() finish.");
    
    NSLog(@"[HelloCauly]CaulyInterstitialAd startInterstitialAdRequest() start.");
    [_caulyInterstitialAd startInterstitialAdRequest];                                       // 전면 광고 요청
    NSLog(@"[HelloCauly]CaulyInterstitialAd startInterstitialAdRequest() finish.");
}

@end

@implementation CaulyInterstitialAdCallback

- (instancetype)init:(CaulyInterstitialAd*)caulyInterstitialAd flutterMethodChannel:(FlutterMethodChannel *)initializeChannel {
    self = [super init];
    if (self) {
        _caulyInterstitialAd = caulyInterstitialAd;
        _flutterMethodChannel = initializeChannel;
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
    [_flutterMethodChannel invokeMethod:@"onReceiveInterstitialAd" arguments:nil];
}

- (void)didFailToReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd errorCode:(int)errorCode errorMsg:(NSString *)errorMsg{
    NSLog(@"[HelloCauly]didFailToReceiveInterstitialAd");
    [_flutterMethodChannel invokeMethod:@"onFailToReceiveInterstitialAd" arguments:nil];
}

- (void)willShowInterstitialAd:(CaulyInterstitialAd *)interstitialAd{
    NSLog(@"[HelloCauly]willShowInterstitialAd");
    [_flutterMethodChannel invokeMethod:@"onWillShowInterstitialAd" arguments:nil];
}

- (void)didCloseInterstitialAd:(CaulyInterstitialAd *)interstitialAd{
    NSLog(@"[HelloCauly]didCloseInterstitialAd");
    _caulyInterstitialAd = nil;
    [_flutterMethodChannel invokeMethod:@"onDidCloseInterstitialAd" arguments:nil];
}

@end
