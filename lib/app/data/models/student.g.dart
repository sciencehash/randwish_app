// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    id: json['id'] as String,
    name: json['a'] as String?,
    photoUrl: json['b'] as String?,
    email: json['c'] as String?,
    lang: json['d'] as String? ?? 'sys',
    contentLang: json['e'] as String? ?? 'sys',
    theme: json['f'] as String? ?? 'sys',
    customThemeColor: ModelHelpers.colorFromJson(json['g'] as int?),
    selectedLibraryId: json['h'] as String? ?? '',
    signUpAt: DateTime.parse(json['i'] as String),
    lastPaymentAt:
        json['j'] == null ? null : DateTime.parse(json['j'] as String),
    paymentPeriod: Student._paymentPeriodFromJson(json['k'] as int?),
    isSuspended: json['l'] as bool? ?? false,
    activated: json['u'] as bool,
    config: Student._studentConfigFromJson(json['v']),
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) {
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
  val['e'] = instance.contentLang;
  val['f'] = instance.theme;
  writeNotNull('g', ModelHelpers.colorToJson(instance.customThemeColor));
  val['h'] = instance.selectedLibraryId;
  val['i'] = instance.signUpAt.toIso8601String();
  writeNotNull('j', instance.lastPaymentAt?.toIso8601String());
  writeNotNull('k', Student._paymentPeriodToJson(instance.paymentPeriod));
  val['l'] = instance.isSuspended;
  val['u'] = instance.activated;
  val['v'] = instance.config.toJson();
  return val;
}

StudentConfig _$StudentConfigFromJson(Map<String, dynamic> json) {
  return StudentConfig(
    avoidInstallMobileAppMsg: json['a'] as bool? ?? false,
  );
}

Map<String, dynamic> _$StudentConfigToJson(StudentConfig instance) =>
    <String, dynamic>{
      'a': instance.avoidInstallMobileAppMsg,
    };
