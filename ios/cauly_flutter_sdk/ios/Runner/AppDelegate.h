#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

#import "Cauly.h"
#import "CaulyAdView.h"
#import "CaulyInterstitialAd.h"
#import "CaulyNativeAd.h"

@interface AppDelegate : FlutterAppDelegate
@property (strong, nonatomic) CaulyAdSetting *caulyAdSetting;
@property (strong, nonatomic) CaulyInterstitialAd *caulyInterstitialAd;
@property (strong, nonatomic) FlutterViewController *flutterViewController;
@property (strong, nonatomic) FlutterMethodChannel *flutterMethodChannel;
@end

@interface CaulyInterstitialAdCallback : NSObject <CaulyInterstitialAdDelegate>
@property (strong, nonatomic) CaulyInterstitialAd *caulyInterstitialAd;
@property (strong, nonatomic) FlutterMethodChannel *flutterMethodChannel;
- (instancetype)init:(CaulyInterstitialAd*)caulyInterstitialAd flutterMethodChannel:(FlutterMethodChannel *)flutterMethodChannel;
- (void)show;
@end
