# 목차
1. [CAULY Flutter Plugin 시작하기](#1-CAULY-Flutter-Plugin-시작하기)
    * [Flutter 설치 경로 확인 및 추가](#Flutter-설치-경로-확인-및-추가)
    * [CAULY SDK 추가](#cauly-sdk-추가)   
    * [Flutter Plugin 프로젝트루트경로/android/src/main의 AndroidManifest.xml 속성 지정](#Flutter-Plugin-프로젝트루트경로/android/src/main의-AndroidManifest.xml-속성-지정)
    * [proguard 설정](#proguard-설정-하는-경우-cauly-sdk-포함된-class는-난독화-시키시면-안됩니다)
    * [AndroidX 설정](#androidx-사용하는-경우)
2. [배너 및 전면 광고 추가하기(안드로이드 진영 연결 코드)](#2-배너-및-전면-광고-추가하기(안드로이드-진영-연결-코드))
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/AdInstanceManager.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/AdMessageCodec.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/BannerAdCreator.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/CaulyAdsViewFactory.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/CaulyFlutterSdkPlugin.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)    
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterAd.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterAdInfo.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterAdLoader.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterBannerAd.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterBannerAdListener.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterInterstitialAd.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterPlatformView.java 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)    
3. [배너 및 전면 광고 추가하기(dart 진영 연결 코드)](#2-배너-및-전면-광고-추가하기(dart-진영-연결-코드)) 
    * [Flutter Plugin 프로젝트루트경로/lib/src/ad_containers.dart 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/lib/src/ad_instance_manager.dart 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/lib/src/ad_listeners.dart 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/lib/src/mobile_ads.dart 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/lib/cauly_mobile_ads.dart 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
    * [Flutter Plugin 프로젝트루트경로/example/lib/main.dart 추가](#자세한-내용은-‘cauly_flutter_sdk’-참조)
4. [실행하기](#3-실행하기)
    * [Flutter Plugin 프로젝트 실행을 위한 명령어 실행](#Flutter-Plugin-프로젝트-실행을-위한-명령어-실행)

- - - 
# 1. CAULY Flutter Plugin 시작하기
이 프로젝트는 Cauly Android SDK Flutter 연동 예제 프로젝트입니다.
Flutter 예제는 Flutter Plugin 프로젝트이며, Android 5.0(Lollipop, API Level 21) 이상 기기와 JDK 11 이상에서 동작합니다.
최신 버전의 Cauly Android SDK 사용을 권장합니다.(최신버전: 3.5.26)
최신 버전의 Android Studio와 Visual Studio Code 사용을 권장합니다. Eclipse에 대한 기술 지원은 하지 않습니다.

### Flutter 설치 경로 확인 및 추가
Flutter Plugin 프로젝트루트경로/android/local.properties 파일에 flutter 설치 경로 확인 후 없으면 추가합니다.
```properties
    ... 
    //예시
    flutter.sdk=/Users/유저명/flutter
    ...
```

### CAULY SDK 추가
	
- Flutter Plugin 프로젝트루트경로/android/build.gradle 에  maven repository 추가

	```clojure
	allprojects {
	    repositories {
        	google()
	        mavenCentral()
        	maven {
            	url "s3://repo.cauly.net/releases"
		credentials(AwsCredentials) {
			accessKey "AKIAWRZUK5MFKYVSUOLB"
                	secretKey "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"
			}
		}
	    }
	}
	```
	
- Flutter Plugin 프로젝트루트경로/android/build.gradle 에 'dependencies'  추가

	```clojure
 	dependencies {
	implementation 'com.google.android.gms:play-services-ads-identifier:17.0.0'
	implementation 'com.google.android.gms:play-services-appset:16.0.0'
    implementation 'com.fsn.cauly:cauly-sdk:3.5.26' 
    }
	```



### Flutter Plugin 프로젝트루트경로/android/src/main의 AndroidManifest.xml 속성 지정

#### 필수 퍼미션 추가
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
```

#### 네트워크 보안 설정 (targetSdkVersion 28 이상)

`광고 노출 및 클릭이 정상적으로 동작하기 위해서 cleartext 네트워크 설정 필요`

```xml
<application android:usesCleartextTraffic="true" />
```	

#### 더 안전한 구성요소 내보내기 설정 (targetSdkVersion 31 이상)
`intent-filter를 사용하는 활동을 포함하는 경우 android:exported 속성 설정 필요 (MAIN/LAUNCHER activity는 ture 설정 필수)`

```xml
<activity android:exported="true" />
``` 


#### Activity orientation
- Activity 형식의 전체 화면 랜딩을 지원하기 위해선 아래의 설정으로 추가한다.
- 만약, 설정하지 않으면 화면 전환 시 마다 광고view 가 `초기화` 됩니다.

```xml
<activity
    android:name=".MainActivity"
    android:configChanges="keyboard|keyboardHidden|orientation|screenSize">
</activity>
```

```xml
<activity
    android:name="com.fsn.cauly.blackdragoncore.LandingActivity"
    android:configChanges="keyboard|keyboardHidden|orientation|screenSize"> 
</activity>
```

### proguard 설정 하는 경우 cauly SDK 포함된 Class는 난독화 시키시면 안됩니다.

```clojure
proguard-rules.pro ::
-keep public class com.fsn.cauly.** {
      public protected *;
}
-keep public class com.trid.tridad.** {
  	  public protected *;
}
-dontwarn android.webkit.**

- Android Studio 3.4 이상 부터 (gradle build tool 3.4.0)는 아래 와 같이 설정 해야합니다.

-keep class com.fsn.cauly.** {
	   public *; protected *;
}
-keep class com.trid.tridad.** {
  	  public *; protected *;
}
-dontwarn android.webkit.**
```
	
### AndroidX 사용하는 경우
```xml
Flutter Plugin 프로젝트루트경로/android/gradle.properties ::
 * android.useAndroidX=true
 * android.enableJetifier=true
```

- 참고 : https://developer.android.com/jetpack/androidx/migrate

# 2. 배너 및 전면 광고 추가하기(안드로이드 진영 연결 코드)

안드로이드 클래스는 Cauly Android SDK의 기능인 배너 및 전면 광고 호출하는 역할을 담당합니다.
dart파일에는 사용자와 상호작용할 수 있는 UI코드가 들어가며, 안드로이드 클래스는 사용자가 UI를 통해 배너 및 전면 광고를 호출한 것과 일치하는 Cauly Android SDK 를 호출할 수 있습니다.
dart 파일과 연결을 위해서 필요한 안드로이드 클래스들을 만듭니다.(총 12개의 안드로이드 클래스 파일 구현이 필요)

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/AdInstanceManager.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import android.app.Activity;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class AdInstanceManager {
    @Nullable
    private Activity activity;

    @NonNull
    private final Map<Integer, FlutterAd> ads;
    @NonNull
    private final MethodChannel channel;

    /**
     * Initializes the ad instance manager. We only need a method channel to start
     * loading ads, but an
     * activity must be present in order to attach any ads to the view hierarchy.
     */
    AdInstanceManager(@NonNull MethodChannel channel) {
        this.channel = channel;
        this.ads = new HashMap<>();
    }

    void setActivity(@Nullable Activity activity) {
        this.activity = activity;
    }

    @Nullable
    Activity getActivity() {
        return activity;
    }

    @Nullable
    FlutterAd adForId(int id) {
        return ads.get(id);
    }

    @Nullable
    Integer adIdFor(@NonNull FlutterAd ad) {
        for (Integer adId : ads.keySet()) {
            if (ads.get(adId) == ad) {
                return adId;
            }
        }
        return null;
    }

    void trackAd(@NonNull FlutterAd ad, int adId) {
        if (ads.get(adId) != null) {
            throw new IllegalArgumentException(
                    String.format("Ad for following adId already exists: %d", adId));
        }
        ads.put(adId, ad);
    }

    void disposeAd(int adId) {
        if (!ads.containsKey(adId)) {
            return;
        }
        FlutterAd ad = ads.get(adId);
        if (ad != null) {
            ad.dispose();
        }
        ads.remove(adId);
    }

    void disposeAllAds() {
        for (Map.Entry<Integer, FlutterAd> entry : ads.entrySet()) {
            if (entry.getValue() != null) {
                entry.getValue().dispose();
            }
        }
        ads.clear();
    }

    void onReceiveAd(int adId, boolean isChargeableAd) {
        Map<Object, Object> arguments = new HashMap<>();
        arguments.put("adId", adId);
        arguments.put("isChargeableAd", isChargeableAd);
        arguments.put("eventName", "onReceiveAd");
        invokeOnAdEvent(arguments);
    }

    void onFailedToReceiveAd(int adId, int errorCode, String errorMessage) {
        Map<Object, Object> arguments = new HashMap<>();
        arguments.put("adId", adId);
        arguments.put("errorCode", errorCode);
        arguments.put("errorMessage", errorMessage);
        arguments.put("eventName", "onFailedToReceiveAd");
        invokeOnAdEvent(arguments);
    }

    void onShowLandingScreen(int id) {
        Map<Object, Object> arguments = new HashMap<>();
        arguments.put("adId", id);
        arguments.put("eventName", "onShowLandingScreen");
        invokeOnAdEvent(arguments);
    }

    void onCloseLandingScreen(int adId) {
        Map<Object, Object> arguments = new HashMap<>();
        arguments.put("adId", adId);
        arguments.put("eventName", "onCloseLandingScreen");
        invokeOnAdEvent(arguments);
    }

    void onReceiveInterstitialAd(int adId, boolean isChargeableAd) {
        Map<Object, Object> arguments = new HashMap<>();
        arguments.put("adId", adId);
        arguments.put("isChargeableAd", isChargeableAd);
        arguments.put("eventName", "onReceiveInterstitialAd");
        invokeOnAdEvent(arguments);
    }

    void onFailedToReceiveInterstitialAd(int adId, int errorCode, String errorMessage) {
        Map<Object, Object> arguments = new HashMap<>();
        arguments.put("adId", adId);
        arguments.put("errorCode", errorCode);
        arguments.put("errorMessage", errorMessage);
        arguments.put("eventName", "onFailedToReceiveInterstitialAd");
        invokeOnAdEvent(arguments);
    }

    void onClosedInterstitialAd(int id) {
        Map<Object, Object> arguments = new HashMap<>();
        arguments.put("adId", id);
        arguments.put("eventName", "onClosedInterstitialAd");
        invokeOnAdEvent(arguments);
    }

    void onLeaveInterstitialAd(int adId) {
        Map<Object, Object> arguments = new HashMap<>();
        arguments.put("adId", adId);
        arguments.put("eventName", "onLeaveInterstitialAd");
        invokeOnAdEvent(arguments);
    }

    boolean showAdWithId(int id) {
        final FlutterAd.FlutterOverlayAd ad = (FlutterAd.FlutterOverlayAd) adForId(id);

        if (ad == null) {
            return false;
        }

        ad.show();
        return true;
    }

    /**
     * Invoke the method channel using the UI thread. Otherwise the message gets
     * silently dropped.
     */
    private void invokeOnAdEvent(final Map<Object, Object> arguments) {
        new Handler(Looper.getMainLooper())
                .post(
                        new Runnable() {
                            @Override
                            public void run() {
                                channel.invokeMethod("onAdEvent", arguments);
                            }
                        });
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/AdMessageCodec.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;

import io.flutter.plugin.common.StandardMessageCodec;

public class AdMessageCodec extends StandardMessageCodec {
    // The type values below must be consistent for each platform.
    private static final byte VALUE_AD_REQUEST = (byte) 129;

    @NonNull
    Context context;

    AdMessageCodec(@NonNull Context context) {
        this.context = context;
    }

    void setContext(@NonNull Context context) {
        this.context = context;
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, @NonNull Object value) {
        if(value instanceof FlutterAdInfo){
            stream.write(VALUE_AD_REQUEST);
            final FlutterAdInfo adInfo = (FlutterAdInfo) value;
            writeValue(stream, adInfo.getAppCode());
            writeValue(stream, adInfo.getBannerHeight());
            writeValue(stream, adInfo.getBannerSizeWidth());
            writeValue(stream, adInfo.getBannerSizeHeight());
        }else{
            super.writeValue(stream, value);
        }
    }

    @Nullable
    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
        switch (type){
            case VALUE_AD_REQUEST:
                return new FlutterAdInfo.Builder((String) readValueOfType(buffer.get(), buffer))
                        .bannerHeight((String) readValueOfType(buffer.get(), buffer))
                        .setBannerSize((int) readValueOfType(buffer.get(), buffer), (int) readValueOfType(buffer.get(), buffer))
                        .build();
            default:
                return super.readValueOfType(type, buffer);
        }
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/BannerAdCreator.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java

import android.content.Context;

import androidx.annotation.NonNull;

import com.fsn.cauly.CaulyAdView;

public class BannerAdCreator {

    @NonNull
    private final Context context;

    public BannerAdCreator(@NonNull Context context) {
        this.context = context;
    }

    public CaulyAdView createAdView() {
        return new CaulyAdView(context);
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/CaulyAdsViewFactory.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import android.content.Context;
import android.graphics.Color;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.fsn.cauly.CaulyAdInfo;

import java.util.Locale;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class CaulyAdsViewFactory extends PlatformViewFactory {
    @NonNull
    private final AdInstanceManager manager;

    private static class ErrorTextView implements PlatformView {
        private final TextView textView;

        private ErrorTextView(Context context, String message) {
            textView = new TextView(context);
            textView.setText(message);
            textView.setBackgroundColor(Color.RED);
            textView.setTextColor(Color.YELLOW);
        }

        @Override
        public View getView() {
            return textView;
        }

        @Override
        public void dispose() {
        }
    }

    CaulyAdsViewFactory(@NonNull AdInstanceManager manager) {
        super(StandardMessageCodec.INSTANCE);
        this.manager = manager;
    }

    @NonNull
    @Override
    public PlatformView create(@Nullable Context context, int viewId, @Nullable Object args) {
        final Integer adId = (Integer) args;
        FlutterAd ad = manager.adForId(adId);
        if (ad == null || ad.getPlatformView() == null) {
            return getErrorView(context, adId);
        }
        return ad.getPlatformView();
    }

    /**
     * Returns an ErrorView with a debug message for debug builds only. Otherwise just returns an
     * empty PlatformView.
     */
    private static PlatformView getErrorView(@NonNull final Context context, int adId) {
        final String message =
                String.format(
                        Locale.getDefault(),
                        "This ad may have not been loaded or has been disposed. "
                                + "Ad with the following id could not be found: %d.",
                        adId);

        if (BuildConfig.DEBUG) {
            return new ErrorTextView(context, message);
        } else {
            Log.e(CaulyAdsViewFactory.class.getSimpleName(), message);
            return new PlatformView() {
                @Override
                public View getView() {
                    return new View(context);
                }

                @Override
                public void dispose() {
                    // Do nothing.
                }
            };
        }
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/CaulyFlutterSdkPlugin.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMethodCodec;

/** CaulyFlutterSdkPlugin */
public class CaulyFlutterSdkPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private static final String TAG = "CaulyFlutterSdkPlugin";

  @Nullable
  private FlutterPluginBinding flutterPluginBinding;
  @Nullable
  private AdInstanceManager instanceManager;
  @Nullable
  private AdMessageCodec adMessageCodec;

  private MethodChannel channel;

  private static final String CHANNEL_NAME = "cauly_flutter_sdk";
  private static final String VIEW_TYPE_ID = CHANNEL_NAME + "/ad_widget";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding;
    adMessageCodec = new AdMessageCodec(flutterPluginBinding.getApplicationContext());

    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(),
            CHANNEL_NAME, new StandardMethodCodec(adMessageCodec));
    channel.setMethodCallHandler(this);
    instanceManager = new AdInstanceManager(channel);

    flutterPluginBinding
            .getPlatformViewRegistry()
            .registerViewFactory(VIEW_TYPE_ID, new CaulyAdsViewFactory(instanceManager));
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
    if (instanceManager != null) {
      instanceManager.setActivity(activityPluginBinding.getActivity());
    }
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    if (instanceManager != null) {
      instanceManager.setActivity(null);
    }
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
    if (instanceManager != null) {
      instanceManager.setActivity(activityPluginBinding.getActivity());
    }
  }

  @Override
  public void onDetachedFromActivity() {
    if (instanceManager != null) {
      instanceManager.setActivity(null);
    }
  }


  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (instanceManager == null || flutterPluginBinding == null) {
      Log.e(TAG, "method call received before instanceManager initialized: " + call.method);
      return;
    }
    // Use activity as context if available.
    Context context = (instanceManager.getActivity() != null)
            ? instanceManager.getActivity()
            : flutterPluginBinding.getApplicationContext();

    switch (call.method) {
      case "_init":
        // Internal init. This is necessary to cleanup state on hot restart.
        instanceManager.disposeAllAds();
        result.success(null);
        break;
      case "loadInterstitialAd":
        final FlutterInterstitialAd interstitial = new FlutterInterstitialAd(
                call.<Integer>argument("adId"),
                instanceManager,
                call.argument("adInfo"),
                new FlutterAdLoader(context));
        instanceManager.trackAd(interstitial, call.<Integer>argument("adId"));
        interstitial.load();
        result.success(null);
        break;
      case "loadBannerAd":
        final FlutterBannerAd bannerAd = new FlutterBannerAd(
                call.<Integer>argument("adId"),
                context,
                instanceManager,
                call.argument("adInfo"),
                getBannerAdCreator(context));
        instanceManager.trackAd(bannerAd, call.<Integer>argument("adId"));
        bannerAd.load();
        result.success(null);
        break;
      case "disposeAd":
        instanceManager.disposeAd(call.<Integer>argument("adId"));
        result.success(null);
        break;
      case "showAdWithoutView":
        final boolean adShown = instanceManager.showAdWithId(call.<Integer>argument("adId"));
        if (!adShown) {
          result.error("AdShowError", "Ad failed to show.", null);
          break;
        }
        result.success(null);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @VisibleForTesting
  BannerAdCreator getBannerAdCreator(@NonNull Context context) {
    return new BannerAdCreator(context);
  }

}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterAd.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import androidx.annotation.Nullable;

import io.flutter.plugin.platform.PlatformView;

abstract class FlutterAd {

    protected final int adId;

    FlutterAd(int adId) {
        this.adId = adId;
    }

    /**
     * A {@link FlutterAd} that is overlaid on top of a running application.
     */
    abstract static class FlutterOverlayAd extends FlutterAd {
        abstract void show();

        FlutterOverlayAd(int adId) {
            super(adId);
        }
    }

    abstract void load();

    /**
     * Gets the PlatformView for the ad. Default behavior is to return null. Should
     * be overridden by
     * ads with platform views, such as banner and native ads.
     */
    @Nullable
    PlatformView getPlatformView() {
        return null;
    }

    /**
     * Invoked when dispose() is called on the corresponding Flutter ad object. This
     * perform any
     * necessary cleanup.
     */
    abstract void dispose();
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterAdInfo.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import androidx.annotation.Nullable;

import com.fsn.cauly.CaulyAdInfo;
import com.fsn.cauly.CaulyAdInfoBuilder;

import java.util.Objects;

class FlutterAdInfo {

    private final String appCode;

    @Nullable
    private String bannerHeight;

    @Nullable
    private int bannerSizeWidth;

    @Nullable
    private int bannerSizeHeight;

    protected static class Builder {
        private final String appCode;

        @Nullable
        private String bannerHeight;

        @Nullable
        private int bannerSizeWidth;

        @Nullable
        private int bannerSizeHeight;

        public Builder(String appCode){
            this.appCode = appCode;
        }

        public FlutterAdInfo.Builder bannerHeight(@Nullable String bannerHeight) {
            this.bannerHeight = bannerHeight;
            return this;
        }

        public FlutterAdInfo.Builder setBannerSize(int bannerSizeWidth, int bannerSizeHeight) {
            this.bannerSizeWidth = bannerSizeWidth;
            this.bannerSizeHeight = bannerSizeHeight;
            return this;
        }

        public String getAppCode() {
            return appCode;
        }

        public String getBannerHeight() {
            return bannerHeight;
        }

        public int[] getBannerSize(){
            return new int[] {bannerSizeWidth, bannerSizeHeight};
        }

        FlutterAdInfo build() {
            return new FlutterAdInfo(appCode, bannerHeight, bannerSizeWidth, bannerSizeHeight);
        }

    }

    protected FlutterAdInfo(String appCode, String bannerHeight, int bannerSizeWidth, int bannerSizeHeight){
        this.appCode = appCode;
        this.bannerHeight = bannerHeight;
        this.bannerSizeWidth = bannerSizeWidth;
        this.bannerSizeHeight = bannerSizeHeight;
    }

    protected CaulyAdInfoBuilder updateAdInfoBuilder() {
        CaulyAdInfoBuilder builder =
                new CaulyAdInfoBuilder(appCode);
        if(bannerHeight != null){
            builder.bannerHeight(bannerHeight);
        }
        if(bannerSizeWidth < 0 && bannerSizeHeight < 0){
            builder.setBannerSize(bannerSizeWidth, bannerSizeHeight);
        }
        return builder;
    }

    CaulyAdInfo asAdInfo(){
        return updateAdInfoBuilder().build();
    }

    public String getAppCode() {
        return appCode;
    }

    @Nullable
    public String getBannerHeight() {
        return bannerHeight;
    }

    @Nullable
    public int getBannerSizeWidth() {
        return bannerSizeWidth;
    }

    @Nullable
    public int getBannerSizeHeight() {
        return bannerSizeHeight;
    }



    @Override
    public boolean equals(Object o) {
        if(this == o) return true;
        if(!(o instanceof FlutterAdInfo)) return false;
        FlutterAdInfo that = (FlutterAdInfo) o;
        return appCode.equals(that.appCode)
                && bannerHeight.equals(that.bannerHeight)
                && bannerSizeWidth == that.bannerSizeWidth
                && bannerSizeHeight == that.bannerSizeHeight;
    }

    @Override
    public int hashCode() {
        return Objects.hash(appCode, bannerHeight, bannerSizeWidth, bannerSizeHeight);
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterAdLoader.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.fsn.cauly.CaulyAdInfo;
import com.fsn.cauly.CaulyInterstitialAd;
import com.fsn.cauly.CaulyInterstitialAdListener;

public class FlutterAdLoader {

    @NonNull
    private final Context context;

    public FlutterAdLoader(@NonNull Context context) {
        this.context = context;
    }

    /**
     * Load an interstitial ad.
     */
    public void loadInterstitial(
            @NonNull CaulyAdInfo adInfo,
            @NonNull CaulyInterstitialAdListener loadCallback) {
        CaulyInterstitialAd interstitialAd = new CaulyInterstitialAd();
        interstitialAd.setAdInfo(adInfo);
        interstitialAd.setInterstialAdListener(loadCallback);
        interstitialAd.requestInterstitialAd((Activity) context);
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterBannerAd.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import android.content.Context;
import android.widget.RelativeLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.fsn.cauly.CaulyAdView;

import io.flutter.plugin.platform.PlatformView;

public class FlutterBannerAd extends FlutterAd {

    @NonNull
    private final Context context;
    @NonNull private final RelativeLayout rootView;
    @NonNull
    private final AdInstanceManager manager;
    @NonNull
    private final FlutterAdInfo adInfo;
    @NonNull
    private final BannerAdCreator bannerAdCreator;
    @Nullable
    private CaulyAdView caulyAdView;

    public FlutterBannerAd(
            int adId,
            @NonNull Context context,
            @NonNull AdInstanceManager manager,
            @NonNull FlutterAdInfo adInfo,
            @NonNull BannerAdCreator bannerAdCreator) {
        super(adId);
        this.context = context;
        this.manager = manager;
        this.adInfo = adInfo;
        this.bannerAdCreator = bannerAdCreator;
        this.rootView = new RelativeLayout(context);
    }

    @Override
    void load() {
        clearView();
        caulyAdView = bannerAdCreator.createAdView();
        caulyAdView.setAdInfo(adInfo.asAdInfo());
        caulyAdView.setShowPreExpandableAd(true);
        caulyAdView.setAdViewListener(new FlutterBannerAdListener(adId, manager));
        RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
        params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        rootView.addView(caulyAdView, params);
    }

    @Nullable
    @Override
    PlatformView getPlatformView() {
        if(caulyAdView == null){
            return null;
        }
        return new FlutterPlatformView(rootView);
    }

    @Override
    void dispose() {
        clearView();
    }

    void clearView() {
        if(caulyAdView != null){
            caulyAdView.destroy();
            rootView.removeView(caulyAdView);
        }
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterBannerAdListener.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import androidx.annotation.NonNull;

import com.fsn.cauly.CaulyAdView;
import com.fsn.cauly.CaulyAdViewListener;

public class FlutterBannerAdListener implements CaulyAdViewListener {
    protected final int adId;
    @NonNull
    protected final AdInstanceManager manager;

    FlutterBannerAdListener(int adId, @NonNull AdInstanceManager manager) {
        this.adId = adId;
        this.manager = manager;
    }

    @Override
    public void onReceiveAd(CaulyAdView caulyAdView, boolean isChargeableAd) {
        manager.onReceiveAd(adId, isChargeableAd);
    }

    @Override
    public void onFailedToReceiveAd(CaulyAdView caulyAdView, int errorCode, String errorMessage) {
        manager.onFailedToReceiveAd(adId, errorCode, errorMessage);
    }

    @Override
    public void onShowLandingScreen(CaulyAdView caulyAdView) {
        manager.onShowLandingScreen(adId);
    }

    @Override
    public void onCloseLandingScreen(CaulyAdView caulyAdView) {
        manager.onCloseLandingScreen(adId);
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterInterstitialAd.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.fsn.cauly.CaulyInterstitialAd;
import com.fsn.cauly.CaulyInterstitialAdListener;

import java.lang.ref.WeakReference;

public class FlutterInterstitialAd extends FlutterAd.FlutterOverlayAd {
    private static final String TAG = "FlutterInterstitialAd";

    @NonNull
    private final AdInstanceManager manager;
    @NonNull
    private final FlutterAdInfo adInfo;
    @Nullable
    private CaulyInterstitialAd ad;
    @NonNull
    private final FlutterAdLoader flutterAdLoader;

    public FlutterInterstitialAd(
            int adId,
            @NonNull AdInstanceManager manager,
            @NonNull FlutterAdInfo adInfo,
            @NonNull FlutterAdLoader flutterAdLoader) {
        super(adId);
        this.manager = manager;
        this.adInfo = adInfo;
        this.flutterAdLoader = flutterAdLoader;
    }

    @Override
    void load() {
        flutterAdLoader.loadInterstitial(adInfo.asAdInfo(),
                new DelegatingInterstitialAdLoadCallback(this));
    }

    public void onReceiveInterstitialAd(CaulyInterstitialAd ad, boolean isChargeableAd) {
        this.ad = ad;
        manager.onReceiveInterstitialAd(adId, isChargeableAd);
    }

    public void onFailedToReceiveInterstitialAd(CaulyInterstitialAd ad, int errorCode, String errorMessage) {
        this.ad = ad;
        manager.onFailedToReceiveInterstitialAd(adId, errorCode, errorMessage);
    }

    public void onClosedInterstitialAd(CaulyInterstitialAd ad) {
        this.ad = ad;
        manager.onClosedInterstitialAd(adId);
    }

    public void onLeaveInterstitialAd(CaulyInterstitialAd ad) {
        this.ad = ad;
        manager.onLeaveInterstitialAd(adId);
    }

    @Override
    void dispose() {
        ad = null;
    }

    @Override
    void show() {
        if (ad == null) {
            Log.e(TAG, "Error showing interstitial - the interstitial ad wasn't loaded yet.");
            return;
        }
        if (manager.getActivity() == null) {
            Log.e(TAG, "Tried to show interstitial before activity was bound to the plugin.");
            return;
        }
        ad.show();
    }


    /**
     * An InterstitialAdLoadCallback that just forwards events to a delegate.
     */
    private static final class DelegatingInterstitialAdLoadCallback implements CaulyInterstitialAdListener {

        private final WeakReference<FlutterInterstitialAd> delegate;

        DelegatingInterstitialAdLoadCallback(FlutterInterstitialAd delegate) {
            this.delegate = new WeakReference<>(delegate);
        }

        @Override
        public void onReceiveInterstitialAd(CaulyInterstitialAd caulyInterstitialAd, boolean isChargeableAd) {
            if(delegate.get() != null){
                delegate.get().onReceiveInterstitialAd(caulyInterstitialAd, isChargeableAd);
            }
        }

        @Override
        public void onFailedToReceiveInterstitialAd(CaulyInterstitialAd caulyInterstitialAd, int errorCode, String errorMessage) {
            if(delegate.get() != null){
                delegate.get().onFailedToReceiveInterstitialAd(caulyInterstitialAd, errorCode, errorMessage);
            }
        }

        @Override
        public void onClosedInterstitialAd(CaulyInterstitialAd caulyInterstitialAd) {
            if(delegate.get() != null){
                delegate.get().onClosedInterstitialAd(caulyInterstitialAd);
            }
        }

        @Override
        public void onLeaveInterstitialAd(CaulyInterstitialAd caulyInterstitialAd) {
            if(delegate.get() != null){
                delegate.get().onLeaveInterstitialAd(caulyInterstitialAd);
            }
        }
    }
}
```

#### Flutter Plugin 프로젝트루트경로/android/src/main/패키지명/FlutterPlatformView.java 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` java
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.plugin.platform.PlatformView;

public class FlutterPlatformView implements PlatformView {

    @Nullable private View view;

    FlutterPlatformView(@NonNull View view) {
        this.view = view;
    }

    @Nullable
    @Override
    public View getView() {
        return view;
    }

    @Override
    public void onFlutterViewAttached(@NonNull View flutterView) {
        PlatformView.super.onFlutterViewAttached(flutterView);
    }

    @Override
    public void onFlutterViewDetached() {
        PlatformView.super.onFlutterViewDetached();
    }

    @Override
    public void dispose() {
        this.view = null;
    }
}
```

# 3. 배너 및 전면 광고 추가하기(dart 진영 연결 코드)

안드로이드 클래스를 완성하였다면, 안드로이드 클래스를 호출할 dart파일을 만들어줍니다.
dart파일은 사용자와 직접 상호작용하는 UI코드가 포함되어 있으며, UI를 통해 사용자와 안드로이드 클래스 사이에서 일어나는 배너 및 전면 광고 호출 활동을 연결해주는 매개 역할을 합니다.

#### Flutter Plugin 프로젝트루트경로/lib/src/ad_containers.dart 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]

주의1: 새로 추가한 dart 파일들을 import할 때는 package 명을 넣어줘야 하며, package명은 프로젝트 명과 동일해야 합니다. 예) import 'package:프로젝트명/cauly_mobile_ads.dart';

주의2: visibility_detector 라이브러리를 추가해주어야 합니다.
pubspect.yaml에 다음 코드 추가
``` yaml
dependencies:
  flutter:
    sdk: flutter
  plugin_platform_interface: ^2.0.2
  visibility_detector: ^0.3.3
```

``` dart
import 'dart:async';
import 'dart:io';

import 'package:cauly_flutter_sdk/cauly_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'ad_instance_manager.dart';
import 'ad_listeners.dart';

class AdInfo {
  /// Default constructor for [AdInfo].
  const AdInfo(
      this.appCode,
      this.bannerHeight,
      this.bannerSizeWidth,
      this.bannerSizeHeight);

  final String appCode;
  final BannerHeightEnum bannerHeight;
  final int bannerSizeWidth;
  final int bannerSizeHeight;

  @override
  bool operator ==(Object other) {
    return other is AdInfo &&
        appCode == other.appCode &&
        bannerHeight == other.bannerHeight &&
        bannerSizeWidth == other.bannerSizeWidth &&
        bannerSizeHeight == other.bannerSizeHeight;
  }
}

enum BannerHeightEnum {
  adaptive(originalName: "ADAPTIVE", name4Java: "Adaptive"),
  proportional(originalName: "PROPORTIONAL", name4Java: "Proportional"),
  square(originalName: "SQUARE", name4Java: "Square"),
  fixed(originalName: "FIXED", name4Java: "Fixed"),
  fixed_50(originalName: "FIXED_50", name4Java: "Fixed_50");

  const BannerHeightEnum({required this.originalName, required this.name4Java});

  final String originalName;
  final String name4Java;
}

abstract class Ad {
  /// Frees the plugin resources associated with this ad.
  Future<void> dispose() {
    return instanceManager.disposeAd(this);
  }
}

/// Base class for mobile [Ad] that has an in-line view.
///
/// A valid [adUnitId] and [size] are required.
abstract class AdWithView extends Ad {
  /// Default constructor, used by subclasses.
  AdWithView({required this.listener});

  /// The [AdWithViewListener] for the ad.
  final AdWithViewListener listener;

  /// Starts loading this ad.
  ///
  /// Loading callbacks are sent to this [Ad]'s [listener].
  Future<void> load();
}

/// An [Ad] that is overlaid on top of the UI.
abstract class AdWithoutView extends Ad {}

/// Displays an [Ad] as a Flutter widget.
///
/// This widget takes ads inheriting from [AdWithView]
/// (e.g. [BannerAd] and [NativeAd]) and allows them to be added to the Flutter
/// widget tree.
///
/// Must call `load()` first before showing the widget. Otherwise, a
/// [PlatformException] will be thrown.
class AdWidget extends StatefulWidget {
  /// Default constructor for [AdWidget].
  ///
  /// [ad] must be loaded before this is added to the widget tree.
  const AdWidget({Key? key, required this.ad}) : super(key: key);

  /// Ad to be displayed as a widget.
  final AdWithView ad;

  @override
  State<AdWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  bool _adIdAlreadyMounted = false;
  bool _adLoadNotCalled = false;
  bool _firstVisibleOccurred = false;

  @override
  void initState() {
    super.initState();
    final int? adId = instanceManager.adIdFor(widget.ad);
    if (adId != null) {
      if (instanceManager.isWidgetAdIdMounted(adId)) {
        _adIdAlreadyMounted = true;
      }
      instanceManager.mountWidgetAdId(adId);
    } else {
      _adLoadNotCalled = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    final int? adId = instanceManager.adIdFor(widget.ad);
    if (adId != null) {
      instanceManager.unmountWidgetAdId(adId);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Platform.isAndroid) {
      return const SizedBox();
    }

    if (_adIdAlreadyMounted) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('This AdWidget is already in the Widget tree'),
        ErrorHint(
            'If you placed this AdWidget in a list, make sure you create a new instance '
                'in the builder function with a unique ad object.'),
        ErrorHint(
            'Make sure you are not using the same ad object in more than one AdWidget.'),
      ]);
    }
    if (_adLoadNotCalled) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            'AdWidget requires Ad.load to be called before AdWidget is inserted into the tree'),
        ErrorHint(
            'Parameter ad is not loaded. Call Ad.load before AdWidget is inserted into the tree.'),
      ]);
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Do not attach the platform view widget until it will actually become
      // visible. This is a workaround for
      // https://github.com/googleads/googleads-mobile-flutter/issues/580,
      // where impressions are erroneously fired due to how platform views are
      // rendered.
      // TODO (jjliu15): Remove this after the flutter issue is resolved.
      if (_firstVisibleOccurred) {
        return PlatformViewLink(
          viewType: '${instanceManager.channel.name}/ad_widget',
          surfaceFactory:
              (BuildContext context, PlatformViewController controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <
                  Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (PlatformViewCreationParams params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: '${instanceManager.channel.name}/ad_widget',
              layoutDirection: TextDirection.ltr,
              creationParams: instanceManager.adIdFor(widget.ad),
              creationParamsCodec: const StandardMessageCodec(),
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      } else {
        final adId = instanceManager.adIdFor(widget.ad);
        return VisibilityDetector(
          key: Key('android-platform-view-$adId'),
          onVisibilityChanged: (visibilityInfo) {
            if (!_firstVisibleOccurred &&
                visibilityInfo.visibleFraction > 0.01) {
              setState(() {
                _firstVisibleOccurred = true;
              });
            }
          },
          child: Container(),
        );
      }
    }

    throw Exception('is not supported on $defaultTargetPlatform');
  }
}

/// A banner ad.
///
/// This ad can either be overlaid on top of all flutter widgets as a static
/// view or displayed as a typical Flutter widget. To display as a widget,
/// instantiate an [AdWidget] with this as a parameter.
class BannerAd extends AdWithView {
  /// Creates a [BannerAd].
  ///
  /// A valid [adUnitId], nonnull [listener], and nonnull request is required.
  BannerAd({
    required AdWithViewListener listener,
    required this.adInfo,
  }) : super(listener: listener);

  /// Targeting information used to fetch an [Ad].
  final AdInfo adInfo;

  @override
  Future<void> load() async {
    if (Platform.isAndroid) {
      await instanceManager.loadBannerAd(this);
    }
  }

  int get bannerSizeHeight => Platform.isAndroid ? adInfo.bannerSizeHeight : 0;

}

/// A full-screen interstitial ad for the Google Mobile Ads Plugin.
class InterstitialAd extends AdWithoutView {
  InterstitialAd._({
    required this.adInfo,
    required this.adLoadCallback,
  });

  /// Targeting information used to fetch an [Ad].
  final AdInfo adInfo;

  /// Callback to be invoked when the ad finishes loading.
  final InterstitialAdLoadCallback adLoadCallback;

  /// Loads an [InterstitialAd] with the given [adUnitId] and [request].
  static Future<void> load({
    required AdInfo adInfo,
    required InterstitialAdLoadCallback adLoadCallback,
  }) async {
    InterstitialAd ad =
    InterstitialAd._(adInfo: adInfo, adLoadCallback: adLoadCallback);

    if (Platform.isAndroid) {
      await instanceManager.loadInterstitialAd(ad);
    }
  }

  /// Displays this on top of the application.
  ///
  /// Set [fullScreenContentCallback] before calling this method to be
  /// notified of events that occur when showing the ad.
  Future<void> show() {
    return instanceManager.showAdWithoutView(this);
  }
}
```

#### Flutter Plugin 프로젝트루트경로/lib/src/ad_instance_manager.dart 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]

주의: AdInstanceManager생성자의 문자열 파라미터 값은 CaulyFlutterSdkPlugin클래스의 CHANNEL_NAME과 일치해야 합니다.

``` dart
import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ad_containers.dart';

/// Loads and disposes [BannerAds] and [InterstitialAds].
AdInstanceManager instanceManager = AdInstanceManager(
  'cauly_flutter_sdk',
);

/// Maintains access to loaded [Ad] instances and handles sending/receiving
/// messages to platform code.
class AdInstanceManager {
  AdInstanceManager(String channelName)
      : channel = MethodChannel(
    channelName,
    StandardMethodCodec(AdMessageCodec()),
  ) {
    channel.setMethodCallHandler((MethodCall call) async {
      assert(call.method == 'onAdEvent');

      final int adId = call.arguments['adId'];
      final String eventName = call.arguments['eventName'];

      final Ad? ad = adFor(adId);
      if (ad != null) {
        _onAdEvent(ad, eventName, call.arguments);
      } else {
        debugPrint('$Ad with id `$adId` is not available for $eventName.');
      }
    });
  }

  int _nextAdId = 0;
  final _BiMap<int, Ad> _loadedAds = _BiMap<int, Ad>();

  /// Invokes load and dispose calls.
  final MethodChannel channel;

  void _onAdEvent(Ad ad, String eventName, Map<dynamic, dynamic> arguments) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _onAdEventAndroid(ad, eventName, arguments);
    } else {
      throw Exception('is not supported on $defaultTargetPlatform');
    }
  }

  void _onAdEventAndroid(
      Ad ad, String eventName, Map<dynamic, dynamic> arguments) {
    switch (eventName) {
      case 'onReceiveAd':
        _invokeOnReceiveAd(ad, eventName, arguments);
        break;
      case 'onFailedToReceiveAd':
        _invokeOnFailedToReceiveAd(ad, eventName, arguments);
        break;
      case 'onShowLandingScreen':
        _invokeOnShowLandingScreen(ad, eventName);
        break;
      case 'onCloseLandingScreen':
        _invokeOnCloseLandingScreen(ad, eventName);
        break;
      case 'onReceiveInterstitialAd':
        _invokeOnReceiveInterstitialAd(ad, eventName, arguments);
        break;
      case 'onFailedToReceiveInterstitialAd':
        _invokeOnFailedToReceiveInterstitialAd(ad, eventName, arguments);
        break;
      case 'onClosedInterstitialAd':
        _invokeOnClosedInterstitialAd(ad, eventName);
        break;
      case 'onLeaveInterstitialAd':
        _invokeOnLeaveInterstitialAd(ad, eventName);
        break;
      default:
        debugPrint('invalid ad event name: $eventName');
    }
  }

  void _invokeOnReceiveInterstitialAd(
      Ad ad, String eventName, Map<dynamic, dynamic> arguments) {
    if (ad is InterstitialAd) {
      ad.adLoadCallback.onReceiveInterstitialAd.call(ad);
    } else {
      debugPrint('invalid ad: $ad, for event name: $eventName');
    }
  }

  void _invokeOnFailedToReceiveInterstitialAd(
      Ad ad, String eventName, Map<dynamic, dynamic> arguments) {
    if (ad is InterstitialAd) {
      ad.dispose();
      ad.adLoadCallback.onFailedToReceiveInterstitialAd.call(arguments['errorCode'], arguments['errorMessage']);
    } else {
      debugPrint('invalid ad: $ad, for event name: $eventName');
    }
  }

  void _invokeOnClosedInterstitialAd(Ad ad, String eventName) {
    if (ad is InterstitialAd) {
      ad.adLoadCallback.onClosedInterstitialAd?.call(ad);
    } else {
      debugPrint('invalid ad: $ad, for event name: $eventName');
    }
  }

  void _invokeOnLeaveInterstitialAd(Ad ad, String eventName) {
    if (ad is InterstitialAd) {
      ad.adLoadCallback.onLeaveInterstitialAd?.call(ad);
    } else {
      debugPrint('invalid ad: $ad, for event name: $eventName');
    }
  }

  void _invokeOnReceiveAd(
      Ad ad, String eventName, Map<dynamic, dynamic> arguments) {
    if (ad is AdWithView) {
      ad.listener.onReceiveAd?.call(ad);
    } else {
      debugPrint('invalid ad: $ad, for event name: $eventName');
    }
  }

  void _invokeOnFailedToReceiveAd(
      Ad ad, String eventName, Map<dynamic, dynamic> arguments) {
    if (ad is AdWithView) {
      ad.listener.onFailedToReceiveAd?.call(ad, arguments['errorCode'], arguments['errorMessage']);
    } else {
      debugPrint('invalid ad: $ad, for event name: $eventName');
    }
  }

  void _invokeOnShowLandingScreen(Ad ad, String eventName) {
    if (ad is AdWithView) {
      ad.listener.onShowLandingScreen?.call(ad);
    } else {
      debugPrint('invalid ad: $ad, for event name: $eventName');
    }
  }

  void _invokeOnCloseLandingScreen(Ad ad, String eventName) {
    if (ad is AdWithView) {
      ad.listener.onCloseLandingScreen?.call(ad);
    } else {
      debugPrint('invalid ad: $ad, for event name: $eventName');
    }
  }

  /// Returns null if an invalid [adId] was passed in.
  Ad? adFor(int adId) => _loadedAds[adId];

  /// Returns null if an invalid [Ad] was passed in.
  int? adIdFor(Ad ad) => _loadedAds.inverse[ad];

  final Set<int> _mountedWidgetAdIds = <int>{};

  /// Returns true if the [adId] is already mounted in a [WidgetAd].
  bool isWidgetAdIdMounted(int adId) => _mountedWidgetAdIds.contains(adId);

  /// Indicates that [adId] is mounted in widget tree.
  void mountWidgetAdId(int adId) => _mountedWidgetAdIds.add(adId);

  /// Indicates that [adId] is unmounted from the widget tree.
  void unmountWidgetAdId(int adId) => _mountedWidgetAdIds.remove(adId);

  /// Starts loading the ad if not previously loaded.
  ///
  /// Does nothing if we have already tried to load the ad.
  Future<void> loadBannerAd(BannerAd ad) {
    if (adIdFor(ad) != null) {
      return Future<void>.value();
    }

    final int adId = _nextAdId++;
    _loadedAds[adId] = ad;
    return channel.invokeMethod<void>(
      'loadBannerAd',
      <dynamic, dynamic>{
        'adId': adId,
        'adInfo': ad.adInfo,
      },
    );
  }

  Future<void> loadInterstitialAd(InterstitialAd ad) {
    if (adIdFor(ad) != null) {
      return Future<void>.value();
    }

    final int adId = _nextAdId++;
    _loadedAds[adId] = ad;
    return channel.invokeMethod<void>(
      'loadInterstitialAd',
      <dynamic, dynamic>{
        'adId': adId,
        'adInfo': ad.adInfo,
      },
    );
  }

  /// Free the plugin resources associated with this ad.
  ///
  /// Disposing a banner ad that's been shown removes it from the screen.
  /// Interstitial ads can't be programmatically removed from view.
  Future<void> disposeAd(Ad ad) {
    final int? adId = adIdFor(ad);
    final Ad? disposedAd = _loadedAds.remove(adId);
    if (disposedAd == null) {
      return Future<void>.value();
    }
    return channel.invokeMethod<void>(
      'disposeAd',
      <dynamic, dynamic>{
        'adId': adId,
      },
    );
  }

  /// Display an [AdWithoutView] that is overlaid on top of the application.
  Future<void> showAdWithoutView(AdWithoutView ad) {
    assert(
    adIdFor(ad) != null,
    '$Ad has not been loaded or has already been disposed.',
    );

    return channel.invokeMethod<void>(
      'showAdWithoutView',
      <dynamic, dynamic>{
        'adId': adIdFor(ad),
      },
    );
  }
}

@visibleForTesting
class AdMessageCodec extends StandardMessageCodec {
  // The type values below must be consistent for each platform.
  static const int _valueAdRequest = 129;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is AdInfo) {
      buffer.putUint8(_valueAdRequest);
      writeValue(buffer, value.appCode);
      writeValue(buffer, value.bannerHeight.name4Java);
      writeValue(buffer, value.bannerSizeWidth);
      writeValue(buffer, value.bannerSizeHeight);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(dynamic type, ReadBuffer buffer) {
    switch (type) {
      case _valueAdRequest:
        return AdInfo(
            readValueOfType(buffer.getUint8(), buffer).cast<String>(),
            readValueOfType(buffer.getUint8(), buffer).cast<String>(),
            readValueOfType(buffer.getUint8(), buffer),
            readValueOfType(buffer.getUint8(), buffer));
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class _BiMap<K extends Object, V extends Object> extends MapBase<K, V> {
  _BiMap() {
    _inverse = _BiMap<V, K>._inverse(this);
  }

  _BiMap._inverse(this._inverse);

  final Map<K, V> _map = <K, V>{};
  late _BiMap<V, K> _inverse;

  _BiMap<V, K> get inverse => _inverse;

  @override
  V? operator [](Object? key) => _map[key];

  @override
  void operator []=(K key, V value) {
    assert(!_map.containsKey(key));
    assert(!inverse.containsKey(value));
    _map[key] = value;
    inverse._map[value] = key;
  }

  @override
  void clear() {
    _map.clear();
    inverse._map.clear();
  }

  @override
  Iterable<K> get keys => _map.keys;

  @override
  V? remove(Object? key) {
    if (key == null) return null;
    final V? value = _map[key];
    inverse._map.remove(value);
    return _map.remove(key);
  }
}
```

#### Flutter Plugin 프로젝트루트경로/lib/src/ad_listeners.dart 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` dart
import 'package:meta/meta.dart';

import 'ad_containers.dart';

/// The callback type to handle an event occurring for an [Ad].
typedef AdEventCallback = void Function(Ad ad);

/// Generic callback type for an event occurring on an Ad.
typedef GenericAdEventCallback<Ad> = void Function(Ad ad);

/// A callback type for when an error occurs loading a full screen ad.
typedef FullScreenAdLoadErrorCallback = void Function(String errorCode, String errorMessage);

/// The callback type to handle an error loading an [Ad].
typedef AdLoadErrorCallback = void Function(Ad ad, String errorCode, String errorMessage);

/// Listener for app events.
class AppEventListener {
  /// Called when an app event is received.
  void Function(Ad ad, String name, String data)? onAppEvent;
}

/// Shared event callbacks used in Native and Banner ads.
abstract class AdWithViewListener {
  /// Default constructor for [AdWithViewListener], meant to be used by subclasses.
  @protected
  const AdWithViewListener({
    this.onReceiveAd,
    this.onFailedToReceiveAd,
    this.onShowLandingScreen,
    this.onCloseLandingScreen,
  });

  /// Called when an ad is successfully received.
  final AdEventCallback? onReceiveAd;

  /// Called when an ad request failed.
  final AdLoadErrorCallback? onFailedToReceiveAd;

  /// A full screen view/overlay is presented in response to the user clicking
  /// on an ad. You may want to pause animations and time sensitive
  /// interactions.
  final AdEventCallback? onShowLandingScreen;

  /// Called when the full screen view has been closed. You should restart
  /// anything paused while handling onCloseLandingScreen.
  final AdEventCallback? onCloseLandingScreen;

}

/// A listener for receiving notifications for the lifecycle of a [BannerAd].
class BannerAdListener extends AdWithViewListener {
  /// Constructs a [BannerAdListener] that notifies for the provided event callbacks.
  ///
  /// Typically you will override [onAdLoaded] and [onAdFailedToLoad]:
  /// ```dart
  /// BannerAdListener(
  ///   onAdLoaded: (ad) {
  ///     // Ad successfully loaded - display an AdWidget with the banner ad.
  ///   },
  ///   onAdFailedToLoad: (ad, error) {
  ///     // Ad failed to load - log the error and dispose the ad.
  ///   },
  ///   ...
  /// )
  /// ```
  const BannerAdListener({
    AdEventCallback? onReceiveAd,
    AdLoadErrorCallback? onFailedToReceiveAd,
    AdEventCallback? onShowLandingScreen,
    AdEventCallback? onCloseLandingScreen,
  }) : super(
    onReceiveAd: onReceiveAd,
    onFailedToReceiveAd: onFailedToReceiveAd,
    onShowLandingScreen: onShowLandingScreen,
    onCloseLandingScreen: onCloseLandingScreen,
  );
}

/// Generic parent class for ad load callbacks.
abstract class FullScreenAdLoadCallback<T> {
  /// Default constructor for [FullScreenAdLoadCallback[, used by subclasses.
  const FullScreenAdLoadCallback({
    required this.onReceiveInterstitialAd,
    required this.onFailedToReceiveInterstitialAd,
    this.onClosedInterstitialAd,
    this.onLeaveInterstitialAd,
  });

  /// Called when the ad successfully loads.
  final GenericAdEventCallback<T> onReceiveInterstitialAd;

  /// Called when an error occurs loading the ad.
  final FullScreenAdLoadErrorCallback onFailedToReceiveInterstitialAd;

  /// A full screen view/overlay is presented in response to the user clicking
  /// on an ad. You may want to pause animations and time sensitive
  /// interactions.
  final AdEventCallback? onClosedInterstitialAd;

  /// Called when the full screen view has been closed. You should restart
  /// anything paused while handling onAdOpened.
  final AdEventCallback? onLeaveInterstitialAd;

}

/// This class holds callbacks for loading an [InterstitialAd].
class InterstitialAdLoadCallback
    extends FullScreenAdLoadCallback<InterstitialAd> {
  /// Construct a [InterstitialAdLoadCallback].
  const InterstitialAdLoadCallback({
    required GenericAdEventCallback<InterstitialAd> onReceiveInterstitialAd,
    required FullScreenAdLoadErrorCallback onFailedToReceiveInterstitialAd,
    AdEventCallback? onClosedInterstitialAd,
    AdEventCallback? onLeaveInterstitialAd,
  }) : super(
    onReceiveInterstitialAd: onReceiveInterstitialAd,
    onFailedToReceiveInterstitialAd: onFailedToReceiveInterstitialAd,
    onClosedInterstitialAd: onClosedInterstitialAd,
    onLeaveInterstitialAd: onLeaveInterstitialAd,
  );
}
```

#### Flutter Plugin 프로젝트루트경로/lib/src/mobile_ads.dart 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` dart
import 'dart:io';

import 'ad_instance_manager.dart';

class MobileAds {
  MobileAds._();

  static final MobileAds _instance = MobileAds._().._init();

  static MobileAds get instance => _instance;

  void initialize() {
    // nothing
  }

  void _init() {
    if (Platform.isAndroid) {
      instanceManager.channel.invokeMethod('_init');
    }
  }
}
```

#### Flutter Plugin 프로젝트루트경로/lib/cauly_mobile_ads.dart 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
``` dart
export 'src/mobile_ads.dart';
export 'src/ad_containers.dart';
export 'src/ad_listeners.dart';
```

#### Flutter Plugin 프로젝트루트경로/example/lib/main.dart 추가 [자세한 내용은 ‘cauly_flutter_sdk’ 참조]
주의1: 새로 추가한 dart 파일들을 import할 때는 package 명을 넣어줘야 하며, package명은 프로젝트 명과 동일해야 합니다. 예) import 'package:프로젝트명/cauly_mobile_ads.dart';
``` dart
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
        adInfo: const AdInfo("test App Code", BannerHeightEnum.adaptive, 320, 50))
      ..load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adInfo: const AdInfo(
            "test App Code",
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
                        child: const Text('전면 광고'))),
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
```

# 4. 실행하기
마지막으로 Flutter 플러그인 프로젝트에서 요구되는 dependency(pubspec.yaml에 추가된 dependency들)를 추가하기 위해 다음 명령어를 순차적으로 실행합니다.

### Flutter Plugin 프로젝트 실행을 위한 명령어 실행
```
flutter clean
flutter pub get
```