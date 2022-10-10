import 'package:json_annotation/json_annotation.dart';

part 'branch_stats.g.dart';

@JsonSerializable()
class BranchStats {
  final int? label;
  final int? count;

  BranchStats({
    this.label,
    this.count,
  });

  factory BranchStats.fromJson(Map<String, dynamic> json) =>
      _$BranchStatsFromJson(json);
}
