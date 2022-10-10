// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      id: json['_id'] as String?,
      url: json['url'] as String?,
      publicId: json['publicId'] as String?,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      '_id': instance.id,
      'url': instance.url,
      'publicId': instance.publicId,
    };
