// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Construction _$ConstructionFromJson(Map<String, dynamic> json) => Construction(
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
      startDate: json['startDate'] as String?,
      finishDate: json['finishDate'] as String?,
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      constructionPhase: json['constructionPhase'] as String?,
      createdAt: json['createdAt'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      lastVisited: json['lastVisited'] as String?,
      constructionId: json['constructionId'] as String?,
    );

Map<String, dynamic> _$ConstructionToJson(Construction instance) =>
    <String, dynamic>{
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
      'startDate': instance.startDate,
      'finishDate': instance.finishDate,
      'branches': instance.branches,
      'constructionPhase': instance.constructionPhase,
      'createdAt': instance.createdAt,
      'lastUpdated': instance.lastUpdated,
      'lastVisited': instance.lastVisited,
      'constructionId': instance.constructionId,
    };
