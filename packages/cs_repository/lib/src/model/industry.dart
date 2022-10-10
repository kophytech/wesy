import 'package:cs_repository/cs_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'industry.g.dart';

@JsonSerializable()
class Industry {
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
  List<Visit>? visits;
  List<dynamic>? images;
  List<Note>? notes;
  List<String>? branches;
  String? createdAt;
  String? lastUpdated;
  String? lastVisited;
  String? datumId;

  Industry({
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
    this.branches,
    this.visits,
    this.images,
    this.notes,
    this.createdAt,
    this.lastUpdated,
    this.lastVisited,
    this.datumId,
  });

  factory Industry.fromJson(Map<String, dynamic> json) =>
      _$IndustryFromJson(json);
}
