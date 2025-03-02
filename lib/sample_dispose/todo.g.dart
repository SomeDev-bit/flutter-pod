// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      desc: json['desc'] as String,
      completed: json['completed'] as bool? ?? false,
      id: json['id'] as String,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'completed': instance.completed,
      'id': instance.id,
    };
