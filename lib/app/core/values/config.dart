import 'package:flutter/foundation.dart';

class AppConfig {
  // App version for About page
  static String get version => '1.0.8+11';

  /// Static data (JSON files) URL
  static String staticDataURL = (kIsWeb
      ? 'https://uolia-data.shash.workers.dev/?${kDebugMode ? 'debug=&' : ''}u=https://static-data.uolia.com/v2'
      : 'https://static-data.uolia.com/v2');

  // Timeout for cache of remote json data files
  static Duration get staticDataCacheTimeout => Duration(days: 1);

  //
  static String hostwindsAffiliateURL = 'https://www.hostwinds.com/9276.html';

  // Uolia social accounts
  static String instagramEN = 'uolia.learning';
  static String instagramES = 'uolialearning';
  static String twitterEN = 'uolialearning';
  static String twitterES = 'uolia_learning';

  // Author social accounts
  static String authorInstagramEN = 'fabian.karaben';
  static String authorInstagramES = 'fabiankaraben';
  static String authorTwitterEN = 'fabkaraben';
  static String authorTwitterES = 'fakaraben';
}
