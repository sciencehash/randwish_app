import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:randwish_app/app/core/utils/helpers/model.dart';

part 'student.g.dart';

enum PaymentPeriod {
  mensual,
  annual,
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class Student extends Equatable {
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
  final String contentLang;

  @JsonKey(
    name: 'f',
    defaultValue: 'sys',
  )
  final String theme;

  @JsonKey(
    name: 'g',
    fromJson: ModelHelpers.colorFromJson,
    toJson: ModelHelpers.colorToJson,
  )
  final Color? customThemeColor;

  @JsonKey(
    name: 'h',
    defaultValue: '',
  )
  final String selectedLibraryId;

  @JsonKey(name: 'i')
  final DateTime signUpAt;

  @JsonKey(name: 'j')
  final DateTime? lastPaymentAt;

  @JsonKey(
    name: 'k',
    fromJson: _paymentPeriodFromJson,
    toJson: _paymentPeriodToJson,
  )
  final PaymentPeriod? paymentPeriod;

  @JsonKey(
    name: 'l',
    defaultValue: false,
  )
  final bool isSuspended;

  // @JsonKey(
  //   name: 'q',
  //   fromJson: _mainCategoriesFromJson,
  // )
  // final List<Category> mainCategories;

  // @JsonKey(
  //   name: 'r',
  //   fromJson: _otherCategoriesFromJson,
  // )
  // final List<Category> otherCategories;

  // @JsonKey(
  //   name: 's',
  //   fromJson: _mainTopicsFromJson,
  // )
  // final List<Topic> mainTopics;

  // @JsonKey(
  //   name: 't',
  //   fromJson: _otherTopicsFromJson,
  // )
  // final List<Topic> otherTopics;

  @JsonKey(name: 'u')
  final bool activated;

  @JsonKey(
    name: 'v',
    fromJson: _studentConfigFromJson,
  )
  final StudentConfig config;

  static PaymentPeriod? _paymentPeriodFromJson(int? index) =>
      index != null ? PaymentPeriod.values[index] : null;

  static int? _paymentPeriodToJson(PaymentPeriod? period) => period?.index;

  // // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  // static List<Category> _mainCategoriesFromJson(val) => (val as List<dynamic>)
  //     .map((e) => Category.fromJson(Map<String, dynamic>.from(e)))
  //     .toList();

  // // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  // static List<Category> _otherCategoriesFromJson(val) => (val as List<dynamic>)
  //     .map((e) => Category.fromJson(Map<String, dynamic>.from(e)))
  //     .toList();

  // // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  // static List<Topic> _mainTopicsFromJson(val) => (val as List<dynamic>)
  //     .map((e) => Topic.fromJson(Map<String, dynamic>.from(e)))
  //     .toList();

  // // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  // static List<Topic> _otherTopicsFromJson(val) => (val as List<dynamic>)
  //     .map((e) => Topic.fromJson(Map<String, dynamic>.from(e)))
  //     .toList();

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static StudentConfig _studentConfigFromJson(val) =>
      StudentConfig.fromJson(Map<String, dynamic>.from(val));

  Student({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.lang,
    required this.contentLang,
    required this.theme,
    required this.customThemeColor,
    required this.selectedLibraryId,
    required this.signUpAt,
    required this.lastPaymentAt,
    required this.paymentPeriod,
    required this.isSuspended,
    // required this.mainCategories,
    // required this.otherCategories,
    // required this.mainTopics,
    // required this.otherTopics,
    required this.activated,
    required this.config,
  });

  Student.minimum({required String id})
      : id = id,
        name = null,
        photoUrl = null,
        email = null,
        lang = 'sys',
        contentLang = 'sys',
        theme = 'sys',
        customThemeColor = null,
        selectedLibraryId = '[create_default]',
        signUpAt = DateTime.now().toUtc(),
        lastPaymentAt = null,
        paymentPeriod = null,
        isSuspended = false,
        // mainCategories = [],
        // otherCategories = [],
        // mainTopics = [],
        // otherTopics = [],
        activated = true,
        config = StudentConfig.minimum();

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        email,
        lang,
        contentLang,
        theme,
        customThemeColor,
        selectedLibraryId,
        signUpAt,
        lastPaymentAt,
        paymentPeriod,
        isSuspended,
        // mainCategories,
        // otherCategories,
        // mainTopics,
        // otherTopics,
        activated,
        config,
      ];

  Student copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? email,
    String? lang,
    String? contentLang,
    String? theme,
    Color? customThemeColor,
    String? selectedLibraryId,
    DateTime? signUpAt,
    DateTime? lastPaymentAt,
    PaymentPeriod? paymentPeriod,
    bool? isSuspended,
    // List<Category>? mainCategories,
    // List<Category>? otherCategories,
    // List<Topic>? mainTopics,
    // List<Topic>? otherTopics,
    bool? activated,
    StudentConfig? config,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      lang: lang ?? this.lang,
      contentLang: contentLang ?? this.contentLang,
      theme: theme ?? this.theme,
      customThemeColor: customThemeColor ?? this.customThemeColor,
      selectedLibraryId: selectedLibraryId ?? this.selectedLibraryId,
      signUpAt: signUpAt ?? this.signUpAt,
      lastPaymentAt: lastPaymentAt ?? this.lastPaymentAt,
      paymentPeriod: paymentPeriod ?? this.paymentPeriod,
      isSuspended: isSuspended ?? this.isSuspended,
      // mainCategories: mainCategories ?? this.mainCategories,
      // otherCategories: otherCategories ?? this.otherCategories,
      // mainTopics: mainTopics ?? this.mainTopics,
      // otherTopics: otherTopics ?? this.otherTopics,
      activated: activated ?? this.activated,
      config: config ?? this.config,
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  //
  // factory Student.fromFirestoreMap(String snapshotId, Map data) {
  //   //
  //   var json = Map<String, dynamic>.from(
  //     data,
  //   );

  //   //
  //   json['id'] = snapshotId;

  //   // Convert 'signUpAt' to DateTime
  //   json['i'] = (json['i'] as Timestamp).toDate().toIso8601String();

  //   // Convert 'lastPaymentAt' to DateTime
  //   json['j'] = (json['j'] as Timestamp?)?.toDate().toIso8601String();

  //   //
  //   return _$StudentFromJson(json);
  // }

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  // Map<String, dynamic> toFirestoreDocument() {
  //   Map<String, dynamic> doc = this.toDocument();

  //   // Convert 'signUpAt' to Firestore Timestamp
  //   doc['i'] = Timestamp.fromDate(DateTime.parse(doc['i']));

  //   // Convert 'lastPaymentAt' to Firestore Timestamp
  //   doc['j'] =
  //       doc['j'] != null ? Timestamp.fromDate(DateTime.parse(doc['j'])) : null;

  //   return doc;
  // }

  // factory Student.fromSembastSnapshot(RecordSnapshot snapshot) {
  //   //
  //   var json = Map<String, dynamic>.from(
  //     snapshot.value,
  //   );

  //   //
  //   json['id'] = snapshot.key as int;

  //   //
  //   return _$StudentFromJson(json);
  // }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class StudentConfig extends Equatable {
  @JsonKey(
    name: 'a',
    defaultValue: false,
  )
  final bool avoidInstallMobileAppMsg;

  StudentConfig({
    required this.avoidInstallMobileAppMsg,
  });

  StudentConfig.minimum() : avoidInstallMobileAppMsg = false;

  @override
  List<Object> get props => [
        avoidInstallMobileAppMsg,
      ];

  StudentConfig copyWith({
    bool? avoidInstallMobileAppMsg,
  }) {
    return StudentConfig(
      avoidInstallMobileAppMsg:
          avoidInstallMobileAppMsg ?? this.avoidInstallMobileAppMsg,
    );
  }

  factory StudentConfig.fromJson(Map<String, dynamic> json) =>
      _$StudentConfigFromJson(json);

  Map<String, dynamic> toJson() {
    // Convert to JSON Map
    Map<String, dynamic> json = _$StudentConfigToJson(this);

    // Remove 'avoidInstallMobileAppMsg' if have its default value
    if (avoidInstallMobileAppMsg == false) json.remove('a');

    return json;
  }

  @override
  bool get stringify => true;
}
