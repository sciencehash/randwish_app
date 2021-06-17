import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:randwish_app/app/core/translations/en_us.dart';
import 'package:randwish_app/app/core/translations/es_es.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'es_ES': es_ES,
        'es': es_ES,
      };
}
