// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
