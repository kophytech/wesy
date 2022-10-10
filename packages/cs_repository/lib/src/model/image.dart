import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {
  @JsonKey(name: '_id')
  final String? id;
  final String? url;
  final String? publicId;

  Image({
    this.id,
    this.url,
    this.publicId,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
