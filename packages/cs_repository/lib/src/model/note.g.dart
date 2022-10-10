// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      text: json['text'] as String?,
      by: json['by'] == null
          ? null
          : By.fromJson(json['by'] as Map<String, dynamic>),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'text': instance.text,
      'by': instance.by!.toJson(),
      '_id': instance.id,
    };
