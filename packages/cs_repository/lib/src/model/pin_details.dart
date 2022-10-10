import 'package:cs_repository/cs_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pin_details.g.dart';

@JsonSerializable()
class PinDetails {
  final String? name;
  final String? city;
  final String? address;
  final String? postalCode;
  final String? company;
  final List<double>? coordinates;
  final String? potential;
  final String? startDate;
  final String? finishDate;
  final String? lastUpdated;
  final String? lastVisited;
  final String? constructionPhase;
  final List<String>? branches;
  // @JsonKey(name: '_id')
  final String? id;
  final String? pinType;
  final Region? region;
  List<Image>? images;
  final List<Visit>? visits;
  final List<Note>? notes;

  PinDetails({
    this.name,
    this.city,
    this.address,
    this.postalCode,
    this.company,
    this.coordinates,
    this.potential,
    this.startDate,
    this.finishDate,
    this.constructionPhase,
    this.branches,
    this.id,
    this.pinType,
    this.lastUpdated,
    this.lastVisited,
    this.region,
    this.images,
    this.visits,
    this.notes,
  });

  factory PinDetails.fromJson(Map<String, dynamic> json) =>
      _$PinDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PinDetailsToJson(this);
}
