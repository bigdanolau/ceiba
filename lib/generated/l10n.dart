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

  /// `Prueba de ingreso`
  String get title {
    return Intl.message(
      'Prueba de ingreso',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Buscar usuario`
  String get search {
    return Intl.message(
      'Buscar usuario',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Buscar Post`
  String get searchPost {
    return Intl.message(
      'Buscar Post',
      name: 'searchPost',
      desc: '',
      args: [],
    );
  }

  /// `Ver publicaciones`
  String get goToPost {
    return Intl.message(
      'Ver publicaciones',
      name: 'goToPost',
      desc: '',
      args: [],
    );
  }

  /// `Leer más`
  String get readMore {
    return Intl.message(
      'Leer más',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Estamos trabajando en esta funcionalidad, estará disponible en una próxima actualización.`
  String get workingOnIt {
    return Intl.message(
      'Estamos trabajando en esta funcionalidad, estará disponible en una próxima actualización.',
      name: 'workingOnIt',
      desc: '',
      args: [],
    );
  }

  /// `Por favor vuelve a conectarte a internet.`
  String get netWorkError {
    return Intl.message(
      'Por favor vuelve a conectarte a internet.',
      name: 'netWorkError',
      desc: '',
      args: [],
    );
  }

  /// `List is empty`
  String get emptyList {
    return Intl.message(
      'List is empty',
      name: 'emptyList',
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
