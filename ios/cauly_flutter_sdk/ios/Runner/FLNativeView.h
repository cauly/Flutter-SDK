#import <Flutter/Flutter.h>
#import "Cauly.h"
#import "CaulyAdView.h"
#import "CaulyInterstitialAd.h"
#import "CaulyNativeAd.h"

@interface FLNativeViewFactory : NSObject <FlutterPlatformViewFactory, CaulyAdViewDelegate, CaulyNativeAdDelegate>
@property (strong, nonatomic) NSObject<FlutterBinaryMessenger>* flutterBinaryMessenger;
@property (strong, nonatomic) FlutterMethodChannel* flutterMethodChannel;
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger flutterMethodChannel:(FlutterMethodChannel *)initializeChannel;
@end

@interface FLNativeView : NSObject <FlutterPlatformView>
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) CaulyAdView *caulyAdView;
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

@end
