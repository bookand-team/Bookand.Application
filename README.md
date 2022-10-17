# BOOK& Mobile Application

---
## 목차
1. [Flutter flavor](#Flutter-flavor)
2. [국제화](#국제화)
3. [JSON 직렬화 코드 생성](#JSON-직렬화-코드-생성)

---
## 1. Flutter flavor

#### 현재 운영 환경은 [dev]와 [product]로 나뉘어져 있음.
#### 따라서 실행 또는 배포하려면 반드시 구분해야함.

### [dev]에서의 실행 방법
```shell
flutter run --flavor dev -t lib/main.dart
```

### [product]에서의 실행 방법
```shell
flutter run --flavor product -t lib/main.dart
```

### [dev]에서의 빌드 방법
#### APK
```shell
flutter build apk --flavor dev -t lib/main.dart
```

#### App Bundle
```shell
flutter build appbundle --flavor dev -t lib/main.dart
```

#### iOS
```shell
flutter build ios --flavor dev -t lib/main.dart
```

### [product]에서의 빌드 방법
#### APK
```shell
flutter build apk --flavor product -t lib/main.dart
```

#### App Bundle
```shell
flutter build appbundle --flavor product -t lib/main.dart
```

#### iOS
```shell
flutter build ios --flavor product -t lib/main.dart
```

---
## 2. 국제화

### 2-1. lib/l10n에 있는 arb파일에 언어별로 사용할 제목, 내용 등 입력
```
{
    "test":"테스트"
}
```

### 2-2. 사용할 페이지에서 아래를 import
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

### 2-3. 사용할 부분에서 아래와 같이 사용
<pre>
<code lang="dart">
AppLocalizations.of(context)!.test
</code>
</pre>

---
## 3. JSON 직렬화 코드 생성

### 모델 클래스에 아래 어노테이션 붙이기
```dart
@JsonSerializable()
```

### 네이밍 전략 변경이 필요하면 해당 변수에 아래 어노테이션 사용
```dart
@JsonKey(name: '사용할 네이밍')
```

### 일회성 코드 생성
```shell
flutter pub run build_runner build
```

### 자동 코드 생성
```shell
flutter pub run build_runner watch
```