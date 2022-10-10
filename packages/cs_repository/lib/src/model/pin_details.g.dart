// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinDetails _$PinDetailsFromJson(Map<String, dynamic> json) => PinDetails(
      name: json['name'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      postalCode: json['postalCode'] as String?,
      company: json['company'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      potential: json['potential'] as String?,
      startDate: json['startDate'] as String?,
      finishDate: json['finishDate'] as String?,
      constructionPhase: json['constructionPhase'] as String?,
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
      pinType: json['pinType'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      lastVisited: json['lastVisited'] as String?,
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      visits: (json['visits'] as List<dynamic>?)
          ?.map((e) => Visit.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PinDetailsToJson(PinDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'city': instance.city,
      'address': instance.address,
      'postalCode': instance.postalCode,
      'company': instance.company,
      'coordinates': instance.coordinates,
      'potential': instance.potential,
      'startDate': instance.startDate,
      'finishDate': instance.finishDate,
      'lastUpdated': instance.lastUpdated,
      'lastVisited': instance.lastVisited,
      'constructionPhase': instance.constructionPhase,
      'branches': instance.branches,
      'id': instance.id,
      'pinType': instance.pinType,
      'region': instance.region!.toJson(),
      'images': instance.images!.map((e) => e.toJson()).toList(),
      'visits': instance.visits!.map((e) => e.toJson()).toList(),
      'notes': instance.notes!.map((e) => e.toJson()).toList(),
    };
