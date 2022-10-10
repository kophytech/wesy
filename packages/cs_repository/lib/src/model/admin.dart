import 'package:cs_repository/src/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin.g.dart';

@JsonSerializable()
class Admin {
  @JsonKey(name: '_id')
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final Region? region;
  final List<String>? roles;

  const Admin({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.region,
    this.roles,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
}
