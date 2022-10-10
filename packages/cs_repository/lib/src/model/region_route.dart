import 'package:cs_repository/cs_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region_route.g.dart';

@JsonSerializable()
class RegionRoute {
  @JsonKey(name: '_id')
  String? id;
  String? routeType;
  String? name;
  List<Pin>? pins;
  String? company;

  RegionRoute({
    this.id,
    this.routeType,
    this.name,
    this.pins,
    this.company,
  });

  factory RegionRoute.fromJson(Map<String, dynamic> json) =>
      _$RegionRouteFromJson(json);
}
