// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:randwish_app/app/core/utils/helpers/model.dart';

part 'app_user.g.dart';

enum PaymentPeriod {
  mensual,
  annual,
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class AppUser extends Equatable {
  // Document ID or Key on local storage
  final String id;

  @JsonKey(name: 'a')
  final String? name;

  @JsonKey(name: 'b')
  final String? photoUrl;

  @JsonKey(name: 'c')
  final String? email;

  @JsonKey(
    name: 'd',
    defaultValue: 'sys',
  )
  final String lang;

  @JsonKey(
    name: 'e',
    defaultValue: 'sys',
  )
  final String theme;

  @JsonKey(
    name: 'f',
    fromJson: ModelHelpers.colorFromJson,
    toJson: ModelHelpers.colorToJson,
  )
  final Color? customThemeColor;

  @JsonKey(
    name: 'g',
    defaultValue: '',
  )
  final String selectedCategoryId;

  @JsonKey(name: 'h')
  final DateTime signUpAt;

  @JsonKey(name: 'i')
  final DateTime? lastPaymentAt;

  @JsonKey(
    name: 'j',
    fromJson: _paymentPeriodFromJson,
    toJson: _paymentPeriodToJson,
  )
  final PaymentPeriod? paymentPeriod;

  @JsonKey(
    name: 'k',
    defaultValue: false,
  )
  final bool isSuspended;

  @JsonKey(
    name: 'v',
    fromJson: _userConfigFromJson,
  )
  final UserConfig config;

  static PaymentPeriod? _paymentPeriodFromJson(int? index) =>
      index != null ? PaymentPeriod.values[index] : null;

  static int? _paymentPeriodToJson(PaymentPeriod? period) => period?.index;

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static UserConfig _userConfigFromJson(val) =>
      UserConfig.fromJson(Map<String, dynamic>.from(val));

  AppUser({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.lang,
    required this.theme,
    required this.customThemeColor,
    required this.selectedCategoryId,
    required this.signUpAt,
    required this.lastPaymentAt,
    required this.paymentPeriod,
    required this.isSuspended,
    required this.config,
  });

  AppUser.minimum({required String id})
      : id = id,
        name = null,
        photoUrl = null,
        email = null,
        lang = 'sys',
        theme = 'sys',
        customThemeColor = null,
        selectedCategoryId = '[create_default]',
        signUpAt = DateTime.now().toUtc(),
        lastPaymentAt = null,
        paymentPeriod = null,
        isSuspended = false,
        config = UserConfig.minimum();

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        email,
        lang,
        theme,
        customThemeColor,
        selectedCategoryId,
        signUpAt,
        lastPaymentAt,
        paymentPeriod,
        isSuspended,
        config,
      ];

  AppUser copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? email,
    String? lang,
    String? theme,
    Color? customThemeColor,
    String? selectedCategoryId,
    DateTime? signUpAt,
    DateTime? lastPaymentAt,
    PaymentPeriod? paymentPeriod,
    bool? isSuspended,
    UserConfig? config,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      lang: lang ?? this.lang,
      theme: theme ?? this.theme,
      customThemeColor: customThemeColor ?? this.customThemeColor,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      signUpAt: signUpAt ?? this.signUpAt,
      lastPaymentAt: lastPaymentAt ?? this.lastPaymentAt,
      paymentPeriod: paymentPeriod ?? this.paymentPeriod,
      isSuspended: isSuspended ?? this.isSuspended,
      config: config ?? this.config,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() {
    // Convert to JSON Map
    Map<String, dynamic> json = _$AppUserToJson(this);

    // Remove 'lang' if have its default value
    if (lang == 'sys') json.remove('d');

    // Remove 'theme' if have its default value
    if (theme == 'sys') json.remove('e');

    // Remove 'selectedCategoryId' if have its default value
    if (selectedCategoryId == '') json.remove('g');

    // Remove 'isSuspended' if have its default value
    if (isSuspended == false) json.remove('k');

    return json;
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class UserConfig extends Equatable {
  @JsonKey(
    name: 'a',
    defaultValue: false,
  )
  final bool avoidInstallMobileAppMsg;

  UserConfig({
    required this.avoidInstallMobileAppMsg,
  });

  UserConfig.minimum() : avoidInstallMobileAppMsg = false;

  @override
  List<Object> get props => [
        avoidInstallMobileAppMsg,
      ];

  UserConfig copyWith({
    bool? avoidInstallMobileAppMsg,
  }) {
    return UserConfig(
      avoidInstallMobileAppMsg:
          avoidInstallMobileAppMsg ?? this.avoidInstallMobileAppMsg,
    );
  }

  factory UserConfig.fromJson(Map<String, dynamic> json) =>
      _$UserConfigFromJson(json);

  Map<String, dynamic> toJson() {
    // Convert to JSON Map
    Map<String, dynamic> json = _$UserConfigToJson(this);

    // Remove 'avoidInstallMobileAppMsg' if have its default value
    if (avoidInstallMobileAppMsg == false) json.remove('a');

    return json;
  }

  @override
  bool get stringify => true;
}
