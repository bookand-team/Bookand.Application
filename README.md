# BOOK&

## 국제화

### 1. lib/l10n에 있는 arb파일에 언어별로 사용할 제목, 내용 등 입력
```
{
    "test":"테스트"
}
```

### 2. 사용할 페이지에서 아래를 import
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

### 3. 사용할 부분에서 아래와 같이 사용
<pre>
<code lang="dart">
AppLocalizations.of(context)!.test
</code>
</pre>

## JSON 직렬화 코드 생성

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