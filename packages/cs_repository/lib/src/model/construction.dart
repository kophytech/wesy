import 'package:cs_repository/cs_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'construction.g.dart';

@JsonSerializable()
class Construction {
  @JsonKey(name: '_id')
  String? id;
  String? pinType;
  String? name;
  Route? route;
  String? address;
  String? city;
  Region? region;
  String? postalCode;
  List<double>? coordinates;
  String? potential;
  String? startDate;
  String? finishDate;
  List<String>? branches;
  String? constructionPhase;
  String? createdAt;
  String? lastUpdated;
  String? lastVisited;
  String? constructionId;

  Construction({
    this.id,
    this.pinType,
    this.name,
    this.route,
    this.address,
    this.city,
    this.region,
    this.postalCode,
    this.coordinates,
    this.potential,
    this.startDate,
    this.finishDate,
    this.branches,
    this.constructionPhase,
    this.createdAt,
    this.lastUpdated,
    this.lastVisited,
    this.constructionId,
  });

  factory Construction.fromJson(Map<String, dynamic> json) =>
      _$ConstructionFromJson(json);
}
