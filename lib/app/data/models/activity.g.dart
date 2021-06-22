// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
    id: json['id'] as String,
    categoryId: json['a'] as String,
    title: json['b'] as String,
    description: json['c'] as String,
    tasks: Activity._tasksFromJson(json['d']),
  );
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'a': instance.categoryId,
      'b': instance.title,
      'c': instance.description,
      'd': instance.tasks.map((e) => e.toJson()).toList(),
    };

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    title: json['c'] as String,
    description: json['d'] as String,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'c': instance.title,
      'd': instance.description,
    };
