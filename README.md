# BOOK& Mobile Application

## 목차
1. [Build Runner](#1-build-runner)
2. [Flutter flavor](#2-flutter-flavor)
3. [JSON 직렬화 코드 생성](#3-json-직렬화-코드-생성)

## 1. Build Runner

#### 프로젝트를 처음 내려받은 경우 또는 각 라이브러리의 generator를 사용하고자 할 때는 아래의 명령어를 터미널에서 실행하여야 함.

### 일회성 코드 생성
```shell
flutter pub run build_runner build
```

### 자동 코드 생성
```shell
flutter pub run build_runner watch
```

## 2. Flutter flavor

#### 현재 운영 환경은 [dev]와 [product]로 나뉘어져 있음.
#### 따라서 실행 또는 배포하려면 반드시 구분해야함.
##### release 로 할 경우 --release 추가

### 실행 방법
```shell
flutter run --flavor [dev/product]
```

### 빌드 방법
#### APK
```shell
flutter build apk --flavor [dev/product]
```

#### App Bundle
```shell
flutter build appbundle --flavor [dev/product]
```

#### iOS
```shell
flutter build ios --flavor [dev/product]
```

#### ipa
```shell
flutter build ipa --flavor [dev/product]
```

## 3. JSON 직렬화 코드 생성

### 모델 클래스에 아래 어노테이션 붙이기
```dart
@JsonSerializable()
```

### 네이밍 전략 변경이 필요하면 해당 변수에 아래 어노테이션 사용
```dart
@JsonKey(name: '사용할 네이밍')
```