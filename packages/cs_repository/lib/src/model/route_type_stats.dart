import 'package:json_annotation/json_annotation.dart';

part 'route_type_stats.g.dart';

@JsonSerializable()
class RouteTypeStats {
  final String? label;
  final int? count;

  RouteTypeStats({
    this.label,
    this.count,
  });

  factory RouteTypeStats.fromJson(Map<String, dynamic> json) =>
      _$RouteTypeStatsFromJson(json);
}
