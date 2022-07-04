// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Api _$ApiFromJson(Map<String, dynamic> json) {
  return Api(
    json['id'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$ApiToJson(Api instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
