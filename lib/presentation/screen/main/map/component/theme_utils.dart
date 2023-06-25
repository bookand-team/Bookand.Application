// ignore_for_file: constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

enum Themes {
  @JsonValue('DETECTIVE')
  DETECTIVE,
  @JsonValue('HISTORY')
  HISTORY,
  @JsonValue('MOVIE')
  MOVIE,
  @JsonValue('MUSIC')
  MUSIC,

  @JsonValue('PET')
  PET,
  @JsonValue('PICTURE')
  PICTURE,
  @JsonValue('TRAVEL')
  TRAVEL,
}

class ThemeUtils {
  static String? theme2Str(Themes theme) {
    switch (theme) {
      case Themes.DETECTIVE:
        return '탐정';
      case Themes.HISTORY:
        return '역사';
      case Themes.MOVIE:
        return '영화';
      case Themes.MUSIC:
        return '음악';
      case Themes.PET:
        return '애완동물';
      case Themes.PICTURE:
        return '사진';
      case Themes.TRAVEL:
        return '여행';
      default:
        return null;
    }
  }

  static Themes? str2Theme(String data) {
    switch (data) {
      case '탐정':
        return Themes.DETECTIVE;
      case '역사':
        return Themes.HISTORY;
      case '영화':
        return Themes.MOVIE;
      case '음악':
        return Themes.MUSIC;
      case '애완동물':
        return Themes.PET;
      case '사진':
        return Themes.PICTURE;
      case '여행':
        return Themes.TRAVEL;
      default:
        return null;
    }
  }
}
