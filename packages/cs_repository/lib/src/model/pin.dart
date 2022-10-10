import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pin.g.dart';

@JsonSerializable()
class Pin extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? address;
  final String? city;
  final String? region;
  final String? postalCode;
  final List<double>? coordinates;
  final String? pinId;

  const Pin({
    this.id,
    this.name,
    this.address,
    this.city,
    this.region,
    this.postalCode,
    this.coordinates,
    this.pinId,
  });

  factory Pin.fromJson(Map<String, dynamic> json) => _$PinFromJson(json);

  Map<String, dynamic> toJson() => _$PinToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        address,
        city,
        region,
        postalCode,
        coordinates,
        pinId,
      ];
}
