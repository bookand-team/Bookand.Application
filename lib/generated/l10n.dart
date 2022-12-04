// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `BOOKAND`
  String get appName {
    return Intl.message(
      'BOOKAND',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get googleSocial {
    return Intl.message(
      'Sign in with Google',
      name: 'googleSocial',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Apple`
  String get appleSocial {
    return Intl.message(
      'Sign in with Apple',
      name: 'appleSocial',
      desc: '',
      args: [],
    );
  }

  /// `Your login has been canceled.`
  String get loginCancel {
    return Intl.message(
      'Your login has been canceled.',
      name: 'loginCancel',
      desc: '',
      args: [],
    );
  }

  /// `Login Error`
  String get loginError {
    return Intl.message(
      'Login Error',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `Please accept\nthe terms and conditions.`
  String get termsOfServiceAgree {
    return Intl.message(
      'Please accept\nthe terms and conditions.',
      name: 'termsOfServiceAgree',
      desc: '',
      args: [],
    );
  }

  /// `All agree`
  String get allAgree {
    return Intl.message(
      'All agree',
      name: 'allAgree',
      desc: '',
      args: [],
    );
  }

  /// `14 years of age or older (required)`
  String get termsOfServiceItem1 {
    return Intl.message(
      '14 years of age or older (required)',
      name: 'termsOfServiceItem1',
      desc: '',
      args: [],
    );
  }

  /// `Accept the terms and conditions of service (required)`
  String get termsOfServiceItem2 {
    return Intl.message(
      'Accept the terms and conditions of service (required)',
      name: 'termsOfServiceItem2',
      desc: '',
      args: [],
    );
  }

  /// `Consent to collect and use personal information (required)`
  String get termsOfServiceItem3 {
    return Intl.message(
      'Consent to collect and use personal information (required)',
      name: 'termsOfServiceItem3',
      desc: '',
      args: [],
    );
  }

  /// `Getting Started`
  String get start {
    return Intl.message(
      'Getting Started',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Agree to the Terms and Conditions of Service`
  String get termsOfService {
    return Intl.message(
      'Agree to the Terms and Conditions of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Agree to collect and use personal information`
  String get collectAndUsePrivacy {
    return Intl.message(
      'Agree to collect and use personal information',
      name: 'collectAndUsePrivacy',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `map`
  String get map {
    return Intl.message(
      'map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `bookmark`
  String get bookmark {
    return Intl.message(
      'bookmark',
      name: 'bookmark',
      desc: '',
      args: [],
    );
  }

  /// `my`
  String get myPage {
    return Intl.message(
      'my',
      name: 'myPage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
