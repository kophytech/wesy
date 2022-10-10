// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Industry _$IndustryFromJson(Map<String, dynamic> json) => Industry(
      id: json['_id'] as String?,
      pinType: json['pinType'] as String?,
      name: json['name'] as String?,
      route: json['route'] == null
          ? null
          : Route.fromJson(json['route'] as Map<String, dynamic>),
      address: json['address'] as String?,
      city: json['city'] as String?,
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
      postalCode: json['postalCode'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      potential: json['potential'] as String?,
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      visits: (json['visits'] as List<dynamic>?)
          ?.map((e) => Visit.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: json['images'] as List<dynamic>?,
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      lastVisited: json['lastVisited'] as String?,
      datumId: json['datumId'] as String?,
    );

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      '_id': instance.id,
      'pinType': instance.pinType,
      'name': instance.name,
      'route': instance.route,
      'address': instance.address,
      'city': instance.city,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'coordinates': instance.coordinates,
      'potential': instance.potential,
      'visits': instance.visits,
      'images': instance.images,
      'notes': instance.notes,
      'branches': instance.branches,
      'createdAt': instance.createdAt,
      'lastUpdated': instance.lastUpdated,
      'lastVisited': instance.lastVisited,
      'datumId': instance.datumId,
    };
