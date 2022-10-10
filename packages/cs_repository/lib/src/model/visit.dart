import 'package:cs_repository/cs_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit.g.dart';

@JsonSerializable()
class Visit {
  String? date;
  String? note;
  By? by;
  String? id;

  Visit({
    this.date,
    this.note,
    this.by,
    this.id,
  });

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);

  Map<String, dynamic> toJson() => _$VisitToJson(this);
}
