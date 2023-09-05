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
