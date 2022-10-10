import 'package:cs_repository/cs_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  String? text;
  By? by;
  @JsonKey(name: '_id')
  String? id;

  Note({
    this.text,
    this.by,
    this.id,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
