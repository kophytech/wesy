// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Route _$RouteFromJson(Map<String, dynamic> json) => Route(
      id: json['_id'] as String?,
      routeType: json['routeType'] as String?,
      name: json['name'] as String?,
      createdBy: json['createdBy'] as String?,
      pins: (json['pins'] as List<dynamic>?)
          ?.map((e) => Pin.fromJson(e as Map<String, dynamic>))
          .toList(),
      workers:
          (json['workers'] as List<dynamic>?)?.map((e) => e as String).toList(),
      company: json['company'] as String?,
    );

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      '_id': instance.id,
      'routeType': instance.routeType,
      'name': instance.name,
      'createdBy': instance.createdBy,
      'pins': instance.pins,
      'workers': instance.workers,
      'company': instance.company,
    };
