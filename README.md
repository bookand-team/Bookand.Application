# BOOK& Mobile Application

## 목차
1. [빌드 방법](#1-빌드-방법)

## 1. 빌드 방법
### 대괄호로 표시한 것을 해당하는 값으로 수정 후 실행

### APK
#### Shell
```shell
flutter build apk -t lib/core/main.dart --flavor [dev/product] \
--dart-define KAKAO_REST_API_KEY=[카카오 REST API Key] \
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key] \
--dart-define IOS_GOOGLE_MAP_API_KEY=[iOS 구글맵 API Key]
```

#### PowerShell
```shell
flutter build apk -t lib/core/main.dart --flavor [dev/product] `
--dart-define KAKAO_REST_API_KEY=[카카오 REST API Key] `
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key] `
--dart-define IOS_GOOGLE_MAP_API_KEY=[iOS 구글맵 API Key]
```

### App Bundle
#### Shell
```shell
flutter build -t lib/core/main.dart appbundle --flavor [dev/product] \
--dart-define KAKAO_REST_API_KEY=[카카오 REST API Key] \
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key] \
--dart-define IOS_GOOGLE_MAP_API_KEY=[iOS 구글맵 API Key]
```

#### PowerShell
```shell
flutter build -t lib/core/main.dart appbundle --flavor [dev/product] `
--dart-define KAKAO_REST_API_KEY=[카카오 REST API Key] `
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key] `
--dart-define IOS_GOOGLE_MAP_API_KEY=[iOS 구글맵 API Key]
```

### iOS
```shell
flutter build -t lib/core/main.dart ios --flavor [dev/product] \
--dart-define KAKAO_REST_API_KEY=[카카오 REST API Key] \
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key] \
--dart-define IOS_GOOGLE_MAP_API_KEY=[iOS 구글맵 API Key]
```

### ipa
```shell
flutter build -t lib/core/main.dart ipa --flavor [dev/product] \
--dart-define KAKAO_REST_API_KEY=[카카오 REST API Key] \
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key] \
--dart-define IOS_GOOGLE_MAP_API_KEY=[iOS 구글맵 API Key]
```
