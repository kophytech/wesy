import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_details.g.dart';

@JsonSerializable()
class RouteDetails extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? routeType;
  final String? name;
  final CreatedBy? createdBy;
  final List<Pin>? pins;
  final List<Worker>? workers;

  const RouteDetails({
    this.id,
    this.routeType,
    this.name,
    this.createdBy,
    this.pins,
    this.workers,
  });

  factory RouteDetails.fromJson(Map<String, dynamic> json) =>
      _$RouteDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RouteDetailsToJson(this);

  @override
  List<Object?> get props => [
        id,
        routeType,
        name,
        createdBy,
        pins,
        workers,
      ];
}

@JsonSerializable()
class CreatedBy {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;

  const CreatedBy({
    this.id,
    this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}
