import 'package:cs_repository/src/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'worker.g.dart';

@JsonSerializable()
class Worker extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final Region? region;
  final List<String>? roles;

  const Worker({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.region,
    this.roles,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => _$WorkerFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        region,
        roles,
      ];
}
