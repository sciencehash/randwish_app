import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class Activity extends Equatable {
  /// Document ID or Key on local storage
  final String id;

  @JsonKey(name: 'a')
  final String categoryId;

  @JsonKey(name: 'b')
  final String title;

  @JsonKey(name: 'c')
  final String description;

  @JsonKey(
    name: 'd',
    fromJson: _tasksFromJson,
  )
  final List<Task> tasks;

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static List<Task> _tasksFromJson(val) => (val as List<dynamic>)
      .map((e) => Task.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  Activity({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.tasks,
  });

  Activity.minimum({
    required String id,
    required String categoryId,
    required String title,
  })  : id = id,
        categoryId = categoryId,
        title = title,
        description = '',
        tasks = [];

  @override
  List<Object?> get props => [
        id,
        categoryId,
        title,
        description,
        tasks,
      ];

  Activity copyWith({
    String? id,
    String? categoryId,
    String? title,
    String? description,
    List<Task>? tasks,
  }) {
    return Activity(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      tasks: tasks ?? this.tasks,
    );
  }

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  @override
  bool get stringify => true;
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class Task extends Equatable {
  @JsonKey(name: 'c')
  final String title;

  @JsonKey(name: 'd')
  final String description;

  Task({
    required this.title,
    required this.description,
  });

  Task.minimum({
    required String title,
    required String description,
  })  : title = title,
        description = description;

  @override
  List<Object?> get props => [
        title,
        description,
      ];

  Task copyWith({
    String? title,
    String? description,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  bool get stringify => true;
}
