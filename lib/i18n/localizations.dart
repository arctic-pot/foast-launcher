import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foast_launcher/i18n/en_us.dart';
import 'package:foast_launcher/i18n/zh_cn.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);
  static final Map<String, Map<String, String>> _languages = {
    'enUS': langEnUS,
    'zhCN': langZhCN,
  };

  String getTranslation(String field) {
    return _languages['${locale.languageCode}${locale.countryCode}']![field] ??
        field;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['enUS', 'zhCN']
        .contains('${locale.languageCode}${locale.countryCode}');
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  static AppLocalizationsDelegate delegate = AppLocalizationsDelegate();
}

// translate
String t(BuildContext context, String field) {
  return AppLocalizations.of(context).getTranslation(field);
}
