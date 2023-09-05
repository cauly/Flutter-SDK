#import "FLNativeView.h"

/**
 Flutter Native View 생성을 위한 클래스
 */
@implementation FLNativeViewFactory {
    NSObject<FlutterBinaryMessenger>* _messenger;
    FlutterMethodChannel* _initializeChannel;
    FLNativeView* _flNativeView;
}

/**
 Flutter Native View Factory 초기화 메서드
 */
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger initializeChannel:(FlutterMethodChannel *)initializeChannel {
  self = [super init];
  if (self) {
    _messenger = messenger;
    _initializeChannel = initializeChannel;
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
    [_initializeChannel invokeMethod:@"onReceiveAd" arguments:nil];
}

// 배너 광고 정보 수신 실패
- (void)didFailToReceiveAd:(CaulyAdView *)adView errorCode:(int)errorCode errorMsg:(NSString *)errorMsg {
    NSLog(@"[HelloCauly]didFailToReceiveAd : %d(%@)", errorCode, errorMsg);
    [_initializeChannel invokeMethod:@"onFailToReceiveAd" arguments:nil];
}

// fullsite 혹은 rich 배너 광고 랜딩 화면 표시
- (void)willShowLandingView:(CaulyAdView *)adView {
    NSLog(@"[HelloCauly]willShowLandingView");
    [_initializeChannel invokeMethod:@"onWillShowLandingView" arguments:nil];
}

// fullsite 혹은 rich 배너 광고 랜딩 화면 닫음
- (void)didCloseLandingView:(CaulyAdView *)adView {
    NSLog(@"[HelloCauly]didCloseLandingView");
    [_initializeChannel invokeMethod:@"onDidCloseLandingView" arguments:nil];
}

#pragma - CaulyNativeAdDelegate
- (void)didReceiveNativeAd:(CaulyNativeAd *)nativeAd isChargeableAd:(BOOL)isChargeableAd{
    NSLog(@"[HelloCauly]didReceiveNativeAd");
    [_initializeChannel invokeMethod:@"onDidReceiveNativeAd" arguments:nil];
}

-(void)didFailToReceiveNativeAd:(CaulyNativeAd *)nativeAd errorCode:(int)errorCode errorMsg:(NSString *)errorMsg{
    NSLog(@"[HelloCauly]didFailToReceiveNativeAd");
    [_initializeChannel invokeMethod:@"onDidFailToReceiveNativeAd" arguments:nil];
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
