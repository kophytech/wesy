import 'package:json_annotation/json_annotation.dart';

part 'by.g.dart';

@JsonSerializable()
class By {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  By({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory By.fromJson(Map<String, dynamic> json) => _$ByFromJson(json);

  Map<String, dynamic> toJson() => _$ByToJson(this);
}
