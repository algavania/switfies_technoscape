// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArticleModel _$$_ArticleModelFromJson(Map<String, dynamic> json) =>
    _$_ArticleModel(
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      content: json['content'] as String,
      readingInMinutes: json['readingInMinutes'] as int,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_ArticleModelToJson(_$_ArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'content': instance.content,
      'readingInMinutes': instance.readingInMinutes,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
