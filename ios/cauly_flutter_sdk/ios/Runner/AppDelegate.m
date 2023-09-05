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
