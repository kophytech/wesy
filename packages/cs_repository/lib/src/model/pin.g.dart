// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pin _$PinFromJson(Map<String, dynamic> json) => Pin(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      region: json['region'] as String?,
      postalCode: json['postalCode'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      pinId: json['pinId'] as String?,
    );

Map<String, dynamic> _$PinToJson(Pin instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'coordinates': instance.coordinates,
      'pinId': instance.pinId,
    };
