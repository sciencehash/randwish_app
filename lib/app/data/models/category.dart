import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class Category extends Equatable {
  /// Document ID or Key on local storage
  final String id;

  @JsonKey(name: 'a')
  final String userId;

  @JsonKey(name: 'b')
  final String title;

  Category({
    required this.id,
    required this.userId,
    required this.title,
  });

  Category.minimum({
    required String id,
    required String userId,
    required String title,
  })  : id = id,
        userId = userId,
        title = title;

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
      ];

  Category copyWith({
    String? id,
    String? userId,
    String? title,
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  bool get stringify => true;
}
