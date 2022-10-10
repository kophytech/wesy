// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visit _$VisitFromJson(Map<String, dynamic> json) => Visit(
      date: json['date'] as String?,
      note: json['note'] as String?,
      by: json['by'] == null
          ? null
          : By.fromJson(json['by'] as Map<String, dynamic>),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'date': instance.date,
      'note': instance.note,
      'by': instance.by!.toJson(),
      '_id': instance.id,
    };
