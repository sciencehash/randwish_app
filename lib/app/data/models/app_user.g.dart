// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return AppUser(
    id: json['id'] as String,
    name: json['a'] as String?,
    photoUrl: json['b'] as String?,
    email: json['c'] as String?,
    lang: json['d'] as String? ?? 'sys',
    theme: json['e'] as String? ?? 'sys',
    customThemeColor: ModelHelpers.colorFromJson(json['f'] as int?),
    selectedCategoryId: json['g'] as String? ?? '',
    signUpAt: DateTime.parse(json['h'] as String),
    lastPaymentAt:
        json['i'] == null ? null : DateTime.parse(json['i'] as String),
    paymentPeriod: AppUser._paymentPeriodFromJson(json['j'] as int?),
    isSuspended: json['k'] as bool? ?? false,
    config: AppUser._userConfigFromJson(json['v']),
  );
}

Map<String, dynamic> _$AppUserToJson(AppUser instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('a', instance.name);
  writeNotNull('b', instance.photoUrl);
  writeNotNull('c', instance.email);
  val['d'] = instance.lang;
  val['e'] = instance.theme;
  writeNotNull('f', ModelHelpers.colorToJson(instance.customThemeColor));
  val['g'] = instance.selectedCategoryId;
  val['h'] = instance.signUpAt.toIso8601String();
  writeNotNull('i', instance.lastPaymentAt?.toIso8601String());
  writeNotNull('j', AppUser._paymentPeriodToJson(instance.paymentPeriod));
  val['k'] = instance.isSuspended;
  val['v'] = instance.config.toJson();
  return val;
}

UserConfig _$UserConfigFromJson(Map<String, dynamic> json) {
  return UserConfig(
    avoidInstallMobileAppMsg: json['a'] as bool? ?? false,
  );
}

Map<String, dynamic> _$UserConfigToJson(UserConfig instance) =>
    <String, dynamic>{
      'a': instance.avoidInstallMobileAppMsg,
    };
