# BOOK& Mobile Application

## 목차
1. [처음 프로젝트 소스를 받는 경우](#1-처음-프로젝트-소스를-받는-경우)
2. [빌드 방법](#2-빌드-방법)

## 1. 처음 프로젝트 소스를 받는 경우
### 자동 생성 파일을 생성해야 정상 작동하므로 build runner 실행 후 사용해야함.

#### 단일 빌드
```shell
flutter pub run build_runner build
```

#### 실시간 빌드
```shell
flutter pub run build_runner watch
```

## 2. 빌드 방법
### 대괄호로 표시한 것을 해당하는 값으로 수정 후 실행

### APK
#### Shell
```shell
flutter build apk -t lib/core/main.dart --flavor [dev/product] \
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key]
```

#### PowerShell
```shell
flutter build apk -t lib/core/main.dart --flavor [dev/product] `
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key]
```

### App Bundle
#### Shell
```shell
flutter build -t lib/core/main.dart appbundle --flavor [dev/product] \
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key]
```

#### PowerShell
```shell
flutter build -t lib/core/main.dart appbundle --flavor [dev/product] `
--dart-define ANDROID_GOOGLE_MAP_API_KEY=[안드로이드 구글맵 API Key]
```

### iOS
```shell
flutter build -t lib/core/main.dart ios --flavor [dev/product] \
--dart-define IOS_GOOGLE_MAP_API_KEY=[iOS 구글맵 API Key]
```

### ipa
```shell
flutter build -t lib/core/main.dart ipa --flavor [dev/product] \
--dart-define IOS_GOOGLE_MAP_API_KEY=[iOS 구글맵 API Key]
```
