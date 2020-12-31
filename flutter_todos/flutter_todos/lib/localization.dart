import 'dart:async';

import 'package:flutter/material.dart';

class FlutterBlocLocalizations {
  static FlutterBlocLocalizations of(BuildContext context) {
    return Localizations.of<FlutterBlocLocalizations>(
      context,
      FlutterBlocLocalizations,
    );
  }

  String get appTitle => "Flutter Todos";
}

class FlutterBlocLocalizationsDelegate
    extends LocalizationsDelegate<FlutterBlocLocalizations> {
  @override
  Future<FlutterBlocLocalizations> load(Locale locale) {
    // TODO: implement load
    return Future(() => FlutterBlocLocalizations());
  }

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<FlutterBlocLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return locale.countryCode.toLowerCase().contains('en');
  }
}
