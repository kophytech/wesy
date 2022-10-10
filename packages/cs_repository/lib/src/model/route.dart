import 'package:cs_repository/cs_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route.g.dart';

@JsonSerializable()
class Route {
  @JsonKey(name: '_id')
  String? id;
  String? routeType;
  String? name;
  String? createdBy;
  List<Pin>? pins;
  List<String>? workers;
  String? company;

  Route({
    this.id,
    this.routeType,
    this.name,
    this.createdBy,
    this.pins,
    this.workers,
    this.company,
  });

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
}
